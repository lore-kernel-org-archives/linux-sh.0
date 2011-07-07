From: kuninori.morimoto.gx@renesas.com
Date: Thu, 07 Jul 2011 01:38:12 +0000
Subject: spu-test-20110706.c
Message-Id: <87box6dg57.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

/*
 * spu-test - AP4 SPU test program, 20110706 Kuninori Morimoto
 *
 * based on
 * vpu-test - AP4 VPU test program, 20110622 Magnus Damm
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <unistd.h>

static int fgets_with_openclose(char *fname, char *buf, size_t maxlen) {
       FILE *fp;

       if ((fp = fopen(fname, "r")) != NULL) {
               fgets(buf, maxlen, fp);
               fclose(fp);
               return strlen(buf);
       } else {
               return -1;
       }
}

struct uio_device {
       char *name;
       char *path;
       int fd;
};

#define MAXUIOIDS  100
#define MAXNAMELEN 256

static int locate_uio_device(char *name, struct uio_device *udp)
{
       char fname[MAXNAMELEN], buf[MAXNAMELEN];
       int uio_id, i;

       for (uio_id = 0; uio_id < MAXUIOIDS; uio_id++) {
               sprintf(fname, "/sys/class/uio/uio%d/name", uio_id);
               if (fgets_with_openclose(fname, buf, MAXNAMELEN) < 0)
                       continue;

               if (strncmp(name, buf, strlen(name)) = 0)
                       break;
       }

       if (uio_id >= MAXUIOIDS)
               return -1;

       udp->name = strdup(buf);
       udp->path = strdup(fname);
       udp->path[strlen(udp->path) - 4] = '\0';

       sprintf(buf, "/dev/uio%d", uio_id);

       udp->fd = open(buf, O_RDWR | O_SYNC);
       if (udp->fd < 0) {
               perror("open");
               return -1;
       }

       return 0;
}

struct uio_map {
       unsigned long address;
       unsigned long size;
       void *iomem;
};

static int setup_uio_map(struct uio_device *udp, int nr, struct uio_map *ump)
{
       char fname[MAXNAMELEN], buf[MAXNAMELEN];
 
       sprintf(fname, "%s/maps/map%d/addr", udp->path, nr);
       if (fgets_with_openclose(fname, buf, MAXNAMELEN) <= 0)
               return -1;

       ump->address = strtoul(buf, NULL, 0);

       sprintf(fname, "%s/maps/map%d/size", udp->path, nr);
       if (fgets_with_openclose(fname, buf, MAXNAMELEN) <= 0)
               return -1;

       ump->size = strtoul(buf, NULL, 0);

       ump->iomem = mmap(0, ump->size,
                         PROT_READ|PROT_WRITE, MAP_SHARED,
                         udp->fd, nr * getpagesize());

       if (ump->iomem = MAP_FAILED)
               return -1;

       return 0;
}

struct uio_device uio_dev;
struct uio_map uio_mmio;

int main(int argc, char *argv[])
{
	int ret;

	ret = locate_uio_device("SPU2DSP0", &uio_dev);
	if (ret < 0) {
		fprintf(stderr, "unable to locate UIO device\n");
		return 1;
	}
       
	ret = setup_uio_map(&uio_dev, 0, &uio_mmio);
	if (ret < 0) {
		fprintf(stderr, "unable to setup UIO memory map\n");
		return 1;
	}

	{
		unsigned long *pb0 = (uio_mmio.iomem + 0xFFC00); /* PBANKC0 */
		unsigned long *pb1 = (uio_mmio.iomem + 0xFFC04); /* PBANKC1 */
		unsigned long *cmd = (uio_mmio.iomem + 0xFFD00); /* DSPRST */

		unsigned long *g0 = (uio_mmio.iomem + 0xFFC40); /* GCOM0 */

		int k;

		if ((*pb0 = 0x00ff &&
		     *pb1 = 0xff00)) {
			printf("detected SPU2DSP0 as %x\n", *cmd);

			if (*g0 = 0xbeef) /* g0 is 24bit */
				printf("SPU2DSP0 state kept since last open\n");

                        /* clear reset */
			if (*cmd)
				*cmd = 0;

			*g0 = 0xbeef;
			return 0;
		}
	}

	fprintf(stderr, "unable to detect/reset SPU2DSP0 \n");
	return 1;
}
