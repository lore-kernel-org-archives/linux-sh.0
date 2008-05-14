From: "Roni Feldman" <roni.feldman+lkml@gmail.com>
Date: Wed, 14 May 2008 19:48:18 +0000
Subject: Best gcc, glibc, busybox versions to use?
Message-Id: <7b5883fc0805141248t99fa61ew74a3209e67cbbbd7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I've been trying to stabilize my setup, but something looks a bit
broken. Calling fcntl() with F_DUPFD seems to return EFAULT (14), no
matter the parameters. I've hooked do_fcntl in the kernel and the call
doesn't get there, meaning it gets stuck in glibc or maybe gcc
generates bad code. I switched the busybox rootfs (meaning, the gcc
and glibc) with a stripped stage1 rootfs I found on the net and
fcntl() works there. I tried to compile busybox 1.8.2 with the gcc
used in that stage1 (3.4.6) and the compilation broke on an undefined
intrinsic __movmem_i4_even, which was probably added to gcc 4.x.

I'm trying to find out the best combination of gcc, glibc, and busybox
versions to build the system, and I was wondering what do you guys use
(I've been using gcc-4.1.2 with glibc-2.5 and busybox 1.8.2 -- this
doesn't seem work) ?

Thanks,
Roni Feldman
