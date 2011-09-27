From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Sep 2011 09:22:51 +0000
Subject: [PATCH] ARM: mach-shmobile: USB boot tool "r_usb_boot"
Message-Id: <20110927092251.29151.94933.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a Renesas specific USB boot tool "r_usb_boot" to the directory
Documentation/arm/SH-Mobile/.

This reusable tool is designed ot runs on the Linux host machine,
connecting to the MASK ROM of the target SoC. The USB boot tool is
used to upload and start code on the SoC. The code is uploaded to
internal SRAM and executed from there.

The USB boot tool is specific to certain SoC models but independent
of board. At this point sh7372 has been tested on AP4EVB and Mackerel
boards and sh73a0 SoC support has been tested on Kota2.

A common use case is to upload a board-specific minimal kernel image
to re-program the NOR Flash or perhaps use kexec to boot a full kernel.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Documentation/arm/SH-Mobile/r_usb_boot.c |  544 ++++++++++++++++++++++++++++++
 1 file changed, 544 insertions(+)

--- /dev/null
+++ work/Documentation/arm/SH-Mobile/r_usb_boot.c	2011-09-27 18:08:23.000000000 +0900
@@ -0,0 +1,544 @@
+/*
+ * USB boot tool for SH-Mobile ARM SoCs
+ *
+ * Boots a stand alone Linux kernel directly from the MASK ROM.
+ * Limited to the size of the MERAM block (1.5 MiB SRAM)
+ *
+ * Tested on sh7372 and sh73a0.
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * Requires libusb, use the following line to build:
+ * $ gcc `pkg-config libusb-1.0 --libs --cflags` r_usb_boot.c -o r_usb_boot
+ *
+ * This program is designed to run on a Linux host computer that is
+ * connected to the target hardware via USB. The target hardware
+ * needs to have USB boot support built into the MASK ROM and the
+ * boot mode pins (MDn) should select "USB Development mode".
+ *
+ * Usage:
+ * # r_usb_boot zImage
+ *
+ * The kernel must include System RAM setup code among other things, as
+ * an example see arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
+ * Important kernel configuration parameters include:
+ *
+ * CONFIG_ZBOOT_ROM=y
+ * CONFIG_ZBOOT_ROM_TEXT=0x0
+ * CONFIG_ZBOOT_ROM_BSS=0xe5580000 (Needs to match MERAM base address)
+ * CONFIG_CMDLINE="..." (This depends on your board)
+ * CONFIG_CMDLINE_FORCE=y
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "libusb.h"
+
+#define HUGECHUNK 0x40000
+#define MAX_FILESIZE (HUGECHUNK * 5) /* 1.5 MiB MERAM, 256 KiB reserved */
+
+struct device_info {
+	char *name;
+	unsigned short vid;
+	unsigned short pid;
+
+	enum { FORMAT_VRL4, FORMAT_VRL5 } format;
+	unsigned int small_chunksize;
+	unsigned int large_chunksize;
+
+} supported_devices[] = {
+	{
+		"sh7372",
+		0x045b, 0x0055,
+		FORMAT_VRL4,
+		64, 4096,
+	},
+	{
+		"sh73a0",
+		0x045b, 0x0060,
+		FORMAT_VRL5,
+		64, 16384,
+	},
+};
+
+#define TIMEOUT 5000
+#define MAX_CHUNK 16384
+
+/* ARM code that copies data in memory */
+static unsigned char mover_code_data[] = {
+	0x02, 0x00, 0x00, 0xea, /* b after_size */
+	0x00, 0x00, 0x00, 0x00, /* src */
+	0x00, 0x00, 0x00, 0x00, /* dst */
+	0x00, 0x00, 0x00, 0x00, /* size */
+
+	0x14, 0x20, 0x1f, 0xe5, /* ldr r2, src */
+	0x14, 0x30, 0x1f, 0xe5, /* ldr r3, dst */
+	0x14, 0x00, 0x1f, 0xe5, /* ldr r0, len */
+
+	0x04, 0x10, 0x92, 0xe4, /* ldr r1,[r2],#4 */
+	0x04, 0x10, 0x83, 0xe4, /* str r1,[r3],#4 */
+	0x04, 0x00, 0x50, 0xe2, /* subs r0,r0,#4 */
+	0xfb, 0xff, 0xff, 0x1a, /* bne before_ldr_r1 */
+
+	0x0e, 0xf0, 0xa0, 0xe1, /* mov	pc, lr */
+};
+
+static int get_hw_version(libusb_device_handle *h)
+{
+	unsigned char get_version[] = { 0xaf, 0x00 };
+	unsigned char data[0x20];
+	int r, r2;
+
+	/* Get Version */
+	r = libusb_bulk_transfer(h, 0x02,
+				 get_version, sizeof(get_version),
+				 &r2, TIMEOUT);
+	if (r)
+		return -1;
+
+	/* Version Information */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data, sizeof(data),
+				 &r2, TIMEOUT);
+
+	if (!r && r2 && (data[0] = 0xbf) && (data[1] = (r2 - 2))) {
+		data[r2] = '\0';
+		printf("Hardware Version Information %s\n", &data[2]);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int status_request_response(libusb_device_handle *h)
+{
+	unsigned char data_out[3] = { 0xa1, 0x01, 0x00 };
+	unsigned char data_in[0x40];
+	int r, r2;
+
+	/* Status Request */
+	r = libusb_bulk_transfer(h, 0x02,
+				 data_out, sizeof(data_out),
+				 &r2, TIMEOUT);
+	if (r || (r2 != sizeof(data_out))) {
+		fprintf(stderr, "Status Request send error\n");
+		return -1;
+	}
+
+	/* Status Response */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data_in, sizeof(data_in),
+				 &r2, TIMEOUT);
+
+	if (r || (r2 != 3) || (data_in[0] != 0xb0)) {
+		fprintf(stderr, "Status is not ok with %d %d 0x%02x 0x%02x\n",
+			r, r2, data_in[0], data_in[2]);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int setup_clocks(libusb_device_handle *h)
+{
+	unsigned char initialize[] = { 0xa0, 0x01, 0x00 };
+	unsigned char data[0x20];
+	int r, r2;
+
+	/* Initialize */
+	r = libusb_bulk_transfer(h, 0x02,
+				 initialize, sizeof(initialize),
+				 &r2, TIMEOUT);
+	if (r)
+		return -1;
+
+	/* Command Response */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data, sizeof(data),
+				 &r2, TIMEOUT);
+	if (r || (r2 != 3) || (data[0] != 0xb0) || (data[2] != 0x00))
+		return -1;
+
+	/* Status Request + Status Response */
+	return status_request_response(h);
+}
+
+static int do_start(libusb_device_handle *h)
+{
+	unsigned char program_start[] = { 0xa5, 0x00 };
+	unsigned char data[0x10];
+	int r, r2;
+
+	/* Program Start */
+	r = libusb_bulk_transfer(h, 0x02,
+				 program_start, sizeof(program_start),
+				 &r2, TIMEOUT);
+	if (r)
+		return -1;
+
+	/* Command Response */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data, sizeof(data),
+				 &r2, TIMEOUT);
+	if (r || (r2 != 3) || (data[0] != 0xb0) || (data[1] != 1)
+	    || (data[2] != 0)) {
+		fprintf(stderr, "Unexpected Program Start Response 0x%02x\n",
+		       data[2]);
+		return -1;
+	}
+	return 0;
+}
+
+static int do_download(libusb_device_handle *h,
+		       int my_chunksize,
+		       unsigned int base_addr,
+		       unsigned char *buf, int no_bytes)
+{
+	unsigned char data[MAX_CHUNK + 7];
+	int k,  r, r2;
+	unsigned int crc, allcrc;
+	int bytes_to_go;
+	int seq;
+	int chunksize;
+
+	allcrc = 0;
+	seq = 0;
+	chunksize = my_chunksize < MAX_CHUNK ? my_chunksize : MAX_CHUNK;
+
+	bytes_to_go = (no_bytes + chunksize - 1) & ~(chunksize - 1);
+
+	/* Download Start */
+	data[0] = 0xa2;
+	data[1] = 0x08;
+	data[2] = (base_addr >> 24) & 0xff;
+	data[3] = (base_addr >> 16) & 0xff;
+	data[4] = (base_addr >> 8) & 0xff;
+	data[5] = base_addr & 0xff;
+	data[6] = (bytes_to_go >> 24) & 0xff;
+	data[7] = (bytes_to_go >> 16) & 0xff;
+	data[8] = (bytes_to_go >> 8) & 0xff;
+	data[9] = bytes_to_go & 0xff;
+	r = libusb_bulk_transfer(h, 0x02,
+				 data, 10,
+				 &r2, TIMEOUT);
+	if (r)
+		return -1;
+
+	/* Download Response */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data, sizeof(data),
+				 &r2, TIMEOUT);
+	if (r || (r2 != 4) || (data[0] != 0xb1))
+		return -1;
+
+	if (data[2] || data[3]) {
+		fprintf(stderr, "Download Start Response is 0x%02x 0x%02x\n",
+		       data[2], data[3]);
+		return -1;
+	}
+
+	/* Status Request + Status Response */
+	status_request_response(h);
+
+	while (bytes_to_go > 0) {
+
+		k = chunksize + 4;
+
+		/* Download Data */
+		data[0] = 0xa3;
+		data[1] = (k >> 8) & 0xff;
+		data[2] = k & 0xff;
+		data[3] = (seq >> 8) & 0xff;
+		data[4] = seq & 0xff;
+
+		crc = 0;
+		for (k = 0; k < chunksize; k++) {
+			crc += buf[k];
+			allcrc += buf[k];
+			data[5 + k] = buf[k];
+		}
+		crc = ~(crc - 1);
+
+		data[chunksize + 5] = (crc >> 8) & 0xff;
+		data[chunksize + 6] = crc & 0xff;
+		r = libusb_bulk_transfer(h, 0x02,
+					 data, chunksize + 7,
+					 &r2, TIMEOUT);
+		if (r)
+			return -1;
+
+		/* Download Response */
+		r = libusb_bulk_transfer(h, 0x81,
+					 data, sizeof(data),
+					 &r2, TIMEOUT);
+		if (r || (r2 != 4) || (data[0] != 0xb1))
+			return -1;
+
+		if (data[2] || data[3]) {
+			fprintf(stderr, "Download Response 0x%02x 0x%02x\n",
+			       data[2], data[3]);
+			return -1;
+		}
+
+		/* Status Request + Status Response */
+		status_request_response(h);
+
+		/* process next chunk */
+		buf += chunksize;
+		bytes_to_go -= chunksize;
+		seq++;
+	}
+
+	/* Download End Confirm */
+	data[0] = 0xa4;
+	data[1] = 0x02;
+
+	allcrc = ~(allcrc - 1);
+	data[2] = (allcrc >> 8) & 0xff;
+	data[3] = allcrc & 0xff;
+
+	r = libusb_bulk_transfer(h, 0x02,
+				 data, 4,
+				 &r2, TIMEOUT);
+	if (r)
+		return -1;
+
+	/* Download End Status */
+	r = libusb_bulk_transfer(h, 0x81,
+				 data, sizeof(data),
+				 &r2, TIMEOUT);
+	if (r || (r2 != 5) || (data[0] != 0xb2))
+		return -1;
+
+	if (data[2]) {
+		fprintf(stderr, "Download End Status is 0x%02x 0x%02x 0x%02x\n",
+		       data[2], data[3], data[4]);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* VRL5 header */
+static unsigned char vrl5_header_file_data[340] = {
+	0x10, 0xf0, 0x9f, 0xe5,
+	0x56, 0x00, 0x00, 0x00,
+	0x20, 0x41, 0x35, 0x47,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+	0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00,
+};
+
+/* VRL4 header */
+static unsigned char vrl4_header_file_data[340] = {
+	0x00, 0x00, 0x00, 0xea,
+	0x56, 0x00, 0x00, 0x00,
+	0x08, 0xf0, 0x9f, 0xe5,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+	0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00,
+};
+
+static int vrl_header(libusb_device_handle *h,
+		      struct device_info *di,
+		      unsigned int start_addr)
+{
+	unsigned char header_buf[340];
+
+	switch (di->format) {
+	case FORMAT_VRL4:
+		memcpy(header_buf, vrl4_header_file_data, sizeof(header_buf));
+		break;
+	case FORMAT_VRL5:
+		memcpy(header_buf, vrl5_header_file_data, sizeof(header_buf));
+		break;
+	default:
+		return -1;
+	}
+
+	/* Fill in start address */
+	header_buf[24] = start_addr & 0xff;
+	header_buf[25] = (start_addr >> 8) & 0xff;
+	header_buf[26] = (start_addr >> 16) & 0xff;
+	header_buf[27] = (start_addr >> 24) & 0xff;
+
+	/* Download VRL header for file at 0xe55b0000 */
+	return do_download(h, di->small_chunksize,
+			   0xe55b0000, header_buf, sizeof(header_buf));
+}
+
+static int run_mover_code(libusb_device_handle *h,
+			  struct device_info *di,
+			  unsigned int src_addr,
+			  unsigned int dst_addr,
+			  unsigned int no_bytes)
+{
+	int ret;
+
+	printf("Moving 0x%08x bytes from 0x%08x to 0x%08x\n",
+	       no_bytes, src_addr, dst_addr);
+
+	mover_code_data[4] = src_addr & 0xff;
+	mover_code_data[5] = (src_addr >> 8) & 0xff;
+	mover_code_data[6] = (src_addr >> 16) & 0xff;
+	mover_code_data[7] = (src_addr >> 24) & 0xff;
+	mover_code_data[8] = dst_addr & 0xff;
+	mover_code_data[9] = (dst_addr >> 8) & 0xff;
+	mover_code_data[10] = (dst_addr >> 16) & 0xff;
+	mover_code_data[11] = (dst_addr >> 24) & 0xff;
+	mover_code_data[12] = no_bytes & 0xff;
+	mover_code_data[13] = (no_bytes >> 8) & 0xff;
+	mover_code_data[14] = (no_bytes >> 16) & 0xff;
+	mover_code_data[15] = (no_bytes >> 24) & 0xff;
+
+	/* Begin loading the headerless code */
+	do_download(h, di->small_chunksize, 0xe55b8000,
+		    mover_code_data, sizeof(mover_code_data));
+
+	/* Download VRL header pointing to 0xe55b8000 */
+	vrl_header(h, di, 0xe55b8000);
+
+	/* Start the mover code */
+	ret = do_start(h);
+
+	/* Check that the code made it back:
+	 * Status Request + Status Response */
+	if (ret = 0)
+		status_request_response(h);
+
+	return ret;
+}
+
+static int rolf(libusb_device_handle *h,
+		struct device_info *di,
+		char *filename)
+{
+	unsigned char file_buf[HUGECHUNK];
+	int k, ret;
+	int fd, filesize;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "unable to open file.\n");
+		return -1;
+	}
+
+	filesize = lseek(fd, 0, SEEK_END);
+	if (filesize = -1) {
+		fprintf(stderr, "unable to seek file.\n");
+		return -1;
+	}
+
+	if (filesize > MAX_FILESIZE) {
+		fprintf(stderr, "filesize %d exceed maximum supported %d.\n",
+			filesize, MAX_FILESIZE);
+		return -1;
+	}
+
+	if (setup_clocks(h) != 0)
+		return -1;
+
+	/* split file in HUGCHUNK size blocks - download top first */
+	for (k = ((filesize + HUGECHUNK - 1) / HUGECHUNK) - 1; k >= 0; k--) {
+
+		printf("Loading 0x%08x bytes to 0x%08x\n",
+		       HUGECHUNK, 0xe55c0000);
+
+		lseek(fd, HUGECHUNK * k, SEEK_SET);
+		read(fd, file_buf, HUGECHUNK);
+
+		/* Download file data chunk */
+		do_download(h, di->large_chunksize,
+			    0xe55c0000, file_buf, HUGECHUNK);
+
+		/* need to move all file data except first block */
+		if (k) {
+			ret = run_mover_code(h, di, 0xe55c0000,
+					     0xe55c0000 + (HUGECHUNK * k),
+					     HUGECHUNK);
+			if (ret != 0)
+				return ret;
+		}
+	}
+
+	/* Download VRL header pointing to 0xe55c0000 */
+	vrl_header(h, di, 0xe55c0000);
+
+	printf("Starting program at 0x%08x\n", 0xe55c0000);
+
+	/* Start the data in the file */
+	do_start(h);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct libusb_device_handle *h;
+	int k;
+	int ret;
+
+	ret = libusb_init(NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Unable to init libusb\n");
+		exit(1);
+	}
+
+	for (k = 0;
+	     k < sizeof(supported_devices) / sizeof(supported_devices[0]);
+	     k++) {
+
+		h = libusb_open_device_with_vid_pid(NULL,
+						    supported_devices[k].vid,
+						    supported_devices[k].pid);
+
+		if (h) {
+			printf("Detected %s\n",
+			       supported_devices[k].name);
+			break;
+		}
+	}
+
+	if (!h) {
+		fprintf(stderr, "Unable to locate device\n");
+		goto out;
+	}
+
+	/* ttyACM is assigned by default, disconnect that driver */
+	libusb_detach_kernel_driver(h, 0);
+
+	ret = libusb_claim_interface(h, 1);
+	if (ret < 0) {
+		fprintf(stderr, "Unable to claim interface\n");
+		goto out;
+	}
+
+	if (get_hw_version(h) != 0)
+		goto out2;
+
+	if (argc > 1)
+		rolf(h, &supported_devices[k], argv[1]);
+
+ out2:
+	libusb_release_interface(h, 0);
+ out:
+	libusb_close(h);
+	libusb_exit(NULL);
+
+	return ret >= 0 ? 0 : 1;
+}
