From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Feb 2015 16:16:56 +0000
Subject: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This tool allows to construct and concat multiple I2C messages into one
single transfer. Its aim is to test I2C master controllers, and so there
is no SMBus fallback.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

I've been missing such a tool a number of times now, so I finally got around to
writing it myself. As with all I2C tools, it can be dangerous, but it can also
be very useful when developing. I am not sure if distros should supply it, I'll
leave that to Jean's experience. For embedded build systems, I think this
should be selectable. It is RFC for now because it needs broader testing and some
more beautification. However, I've been using it already to test the i2c_quirk
infrastructure and Renesas I2C controllers.

 tools/Module.mk     |   8 +-
 tools/i2ctransfer.c | 296 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 tools/i2ctransfer.c

diff --git a/tools/Module.mk b/tools/Module.mk
index d14bb0c..62f1238 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -14,7 +14,7 @@ TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
 TOOLS_LDFLAGS	:= -Llib -li2c
 
-TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
+TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget i2ctransfer
 
 #
 # Programs
@@ -32,6 +32,9 @@ $(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)
 $(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
 	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
 
+$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
+	$(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
+
 #
 # Objects
 #
@@ -48,6 +51,9 @@ $(TOOLS_DIR)/i2cset.o: $(TOOLS_DIR)/i2cset.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DI
 $(TOOLS_DIR)/i2cget.o: $(TOOLS_DIR)/i2cget.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h $(INCLUDE_DIR)/i2c/smbus.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
+$(TOOLS_DIR)/i2ctransfer.o: $(TOOLS_DIR)/i2ctransfer.c $(TOOLS_DIR)/i2cbusses.h $(TOOLS_DIR)/util.h version.h
+	$(CC) $(CFLAGS) -Wno-maybe-uninitialized $(TOOLS_CFLAGS) -c $< -o $@
+
 $(TOOLS_DIR)/i2cbusses.o: $(TOOLS_DIR)/i2cbusses.c $(TOOLS_DIR)/i2cbusses.h
 	$(CC) $(CFLAGS) $(TOOLS_CFLAGS) -c $< -o $@
 
diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
new file mode 100644
index 0000000..30923f5
--- /dev/null
+++ b/tools/i2ctransfer.c
@@ -0,0 +1,296 @@
+/*
+    i2ctransfer.c - A user-space program to send concatenated i2c messages
+    Copyright (C) 2015 Wolfram Sang <wsa@sang-engineering.com>
+    Copyright (C) 2015 Renesas Electronics Corporation
+
+    Based on i2cget.c:
+    Copyright (C) 2005-2012  Jean Delvare <jdelvare@suse.de>
+
+    which is based on i2cset.c:
+    Copyright (C) 2001-2003  Frodo Looijaard <frodol@dds.nl>, and
+                             Mark D. Studebaker <mdsxyz123@yahoo.com>
+    Copyright (C) 2004-2005  Jean Delvare
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+*/
+
+#include <sys/ioctl.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include "i2cbusses.h"
+#include "util.h"
+#include "../version.h"
+
+enum parse_state {
+	PARSE_GET_ADDR,
+	PARSE_GET_FLAGS,
+	PARSE_GET_LENGTH,
+	PARSE_GET_DATA
+};
+
+#define PRINT_STDERR	(1 << 0)
+#define PRINT_READ_BUF	(1 << 1)
+#define PRINT_WRITE_BUF	(1 << 2)
+#define PRINT_HEADER	(1 << 3)
+
+static void help(void)
+{
+	fprintf(stderr,
+		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS ADDRESS FLAGS LENGTH [DATA]...\n"
+		"  I2CBUS is an integer or an I2C bus name\n"
+		"  ADDRESS is an integer (0x03 - 0x77)\n"
+		"  FLAGS is one of:\n"
+		"    r (read)\n"
+		"    w (write)\n"
+		"  LENGTH is an integer (0 - 65535)\n"
+		"  DATA are LENGTH bytes, for a write message. They can be shortened by a suffix:\n"
+		"    = (keep value constant until LENGTH)\n"
+		"    + (increase value by 1 until LENGTH)\n"
+		"    - (decrease value by 1 until LENGTH)\n"
+		"\nExample (on bus 0, write 0xbd to 0xc0-0xcf of device 0x50, read a byte from device 0x51):\n"
+		"  # i2ctransfer 0 0x50 w 0x11 0xc0 0xbd= 0x51 r 1\n"
+		);
+}
+
+static int check_funcs(int file)
+{
+	unsigned long funcs;
+
+	/* check adapter functionality */
+	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
+		fprintf(stderr, "Error: Could not get the adapter "
+			"functionality matrix: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (!(funcs & I2C_FUNC_I2C)) {
+		fprintf(stderr, MISSING_FUNC_FMT, "I2C transfers");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned flags)
+{
+	__u32 i, j;
+	FILE *output = flags & PRINT_STDERR ? stderr : stdout;
+
+	for (i = 0; i < nmsgs; i++) {
+		int read = !!(msgs[i].flags & I2C_M_RD);
+		int newline = !!(flags & PRINT_HEADER);
+
+		if (flags & PRINT_HEADER)
+			fprintf(output, "Msg %u: addr 0x%04x, %s, len %u",
+				i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
+		if (read = !!(flags & PRINT_READ_BUF) ||
+		   !read = !!(flags & PRINT_WRITE_BUF)) {
+			if (flags & PRINT_HEADER)
+				fprintf(output, ", buf ");
+			for (j = 0; j < msgs[i].len; j++)
+				fprintf(output, "0x%02x ", msgs[i].buf[j]);
+			newline = 1;
+		}
+		if (newline)
+			fprintf(output, "\n");
+	}
+}
+
+static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
+{
+	fprintf(stderr, "WARNING! This program can confuse your I2C bus, cause data loss and worse!\n");
+	fprintf(stderr, "I will send the following messages to device file %s:\n", filename);
+	print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRITE_BUF);
+
+	fprintf(stderr, "Continue? [y/N] ");
+	fflush(stderr);
+	if (!user_ack(0)) {
+		fprintf(stderr, "Aborting on user request.\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	char c, filename[20];
+	char *end;
+	int i2cbus, address, file, arg_idx = 1;
+	int force = 0, yes = 0, version = 0, verbose = 0;
+	unsigned flag_idx = 0, buf_idx = 0, nmsgs = 0;
+	unsigned long len, raw_data;
+	__u8 data;
+	__u8 *buf;
+	__u16 flags;
+	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];
+	struct i2c_rdwr_ioctl_data rdwr;
+	enum parse_state state = PARSE_GET_ADDR;
+
+	/* handle (optional) arg_idx first */
+	while (arg_idx < argc && argv[arg_idx][0] = '-') {
+		switch (argv[arg_idx][1]) {
+		case 'V': version = 1; break;
+		case 'v': verbose = 1; break;
+		case 'f': force = 1; break;
+		case 'y': yes = 1; break;
+		default:
+			fprintf(stderr, "Error: Unsupported option "
+				"\"%s\"!\n", argv[arg_idx]);
+			help();
+			exit(1);
+		}
+		arg_idx++;
+	}
+
+	if (version) {
+		fprintf(stderr, "i2ctransfer version %s\n", VERSION);
+		exit(0);
+	}
+
+	if (arg_idx = argc) {
+		help();
+		exit(0);
+	}
+
+	i2cbus = lookup_i2c_bus(argv[arg_idx++]);
+	if (i2cbus < 0)
+		exit(1);
+
+	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
+	if (file < 0 || check_funcs(file))
+		exit(1);
+
+	while (arg_idx < argc) {
+		switch (state) {
+		case PARSE_GET_ADDR:
+			address = parse_i2c_address(argv[arg_idx++]);
+			if (address < 0)
+				exit(1);
+
+			if (!force && set_slave_addr(file, address, 0))
+				exit(1);
+
+			msgs[nmsgs].addr = address;
+			state = PARSE_GET_FLAGS;
+			break;
+
+		case PARSE_GET_FLAGS:
+			flag_idx = 0;
+			flags = 0;
+			while ((c = argv[arg_idx][flag_idx])) {
+				switch (c) {
+				case 'r': flags |= I2C_M_RD; break;
+				case 'w': flags &= ~I2C_M_RD; break;
+				default:
+					fprintf(stderr, "Error: Invalid flag '%c'!\n", c);
+					exit(1);
+				}
+				flag_idx++;
+			}
+			msgs[nmsgs].flags = flags;
+			arg_idx++;
+			state = PARSE_GET_LENGTH;
+			break;
+
+		case PARSE_GET_LENGTH:
+			len = strtoul(argv[arg_idx++], &end, 0);
+			if (*end || len > 65535) {
+				fprintf(stderr, "Error: Length invalid!\n");
+				exit(1);
+			}
+
+			msgs[nmsgs].len = len;
+
+			buf = malloc(len);
+			if (!buf) {
+				fprintf(stderr, "Error: No memory for buffer!\n");
+				exit(ENOMEM);
+			}
+			memset(buf, 0, len);
+			msgs[nmsgs].buf = buf;
+
+			if (flags & I2C_M_RD) {
+				nmsgs++;
+				state = PARSE_GET_ADDR;
+			} else {
+				buf_idx = 0;
+				state = PARSE_GET_DATA;
+			}
+
+			break;
+
+		case PARSE_GET_DATA:
+			raw_data = strtoul(argv[arg_idx++], &end, 0);
+			if (raw_data > 255) {
+				fprintf(stderr, "Error: Data byte '%lu' invalid!\n", raw_data);
+				exit(1);
+			}
+			data = raw_data;
+			buf[buf_idx++] = data;
+
+			c = *end;
+			if (c) {
+				for (; buf_idx < len; buf_idx++) {
+					switch (c) {
+					case '+': data++; break;
+					case '-': data--; break;
+					case '=': break;
+					default:
+						fprintf(stderr, "Error: Invalid data byte suffix '%c'!\n", c);
+						exit(1);
+					}
+
+					buf[buf_idx] = data;
+				}
+			}
+
+			if (buf_idx = len) {
+				nmsgs++;
+				state = PARSE_GET_ADDR;
+			}
+
+			break;
+		}
+	}
+
+	if (state != PARSE_GET_ADDR) {
+		fprintf(stderr, "Error: Incomplete message\n");
+		exit(1);
+	}
+
+	if (nmsgs = 0) {
+		help();
+		exit(0);
+	}
+
+	if (!yes && !confirm(filename, msgs, nmsgs))
+		exit(0);
+
+	rdwr.msgs = msgs;
+	rdwr.nmsgs = nmsgs;
+	if (ioctl(file, I2C_RDWR, &rdwr) < 0) {
+		fprintf(stderr, "Error: Sending messages failed: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	close(file);
+
+	print_msgs(msgs, nmsgs, PRINT_READ_BUF | (verbose ? PRINT_HEADER | PRINT_WRITE_BUF : 0));
+
+	/* let Linux free malloced memory on termination */
+	exit(0);
+}
-- 
2.1.4

