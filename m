From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Date: Tue, 19 Aug 2014 12:50:47 +0000
Subject: [PATCH 0/6] R-Car JPEG Processing Unit
Message-Id: <1408452653-14067-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mikhail Ulyanov <mikhail.ulyanov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

This series of patches contains a driver for the JPEG codec integrated
peripheral found in the Renesas R-Car SoCs, JPU clocking and associated
DT documentation.

The driver is implemented within the V4L2 framework as a mem-to-mem device.

It presents two video nodes to userspace, one for the encoding part, and one
for the decoding part.

It was found that the only working mode for encoding is no markers output, so
we generate it with software.

From a userspace point of view the encoding process is typical (S_FMT, REQBUF,
optionally QUERYBUF, QBUF, STREAMON, DQBUF) for both the source and destination
queues. The decoding process requires that the source queue performs S_FMT,
REQBUF, (QUERYBUF), QBUF and STREAMON. After STREAMON on the source queue,
it is possible to perform G_FMT on the destination queue to find out the
processed image width and height in order to be able to allocate an appropriate
buffer - it is assumed that the user does not pass the compressed image width
and height but instead this information is parsed from the jpeg input. This is
done in kernel. Then REQBUF, QBUF and STREAMON on the destination queue complete
the decoding and it is possible to DQBUF from both queues and finish the operation.

During encoding the available formats are: V4L2_PIX_FMT_NV12 and
V4L2_PIX_FMT_NV16 for source and V4L2_PIX_FMT_JPEG for destination.

During decoding the available formats are: V4L2_PIX_FMT_JPEG for source and
V4L2_PIX_FMT_NV12 and V4L2_PIX_FMT_NV16 for destination.

This series of patches is against the 'devel' branch of
kernel.googlesource.com/pub/scm/linux/kernel/git/horms/renesas repo.

Mikhail Ulyanov (6):
  V4L2: Add Renesas R-Car JPEG codec driver.
  ARM: shmobile: r8a7790: Add JPU clock dt and CPG define.
  ARM: shmobile: r8a7790: Add JPU device node.
  ARM: shmobile: r8a7791: Add JPU clock dt and CPG define.
  ARM: shmobile: r8a7791: Add JPU device node.
  devicetree: bindings: Document Renesas JPEG Processing Unit.

 .../devicetree/bindings/media/renesas,jpu.txt      |   23 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   13 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   13 +-
 drivers/media/platform/Kconfig                     |   11 +
 drivers/media/platform/Makefile                    |    2 +
 drivers/media/platform/jpu.c                       | 1630 ++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h          |    1 +
 include/dt-bindings/clock/r8a7791-clock.h          |    1 +
 8 files changed, 1691 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,jpu.txt
 create mode 100644 drivers/media/platform/jpu.c

-- 
2.1.0.rc1

