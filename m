From: Paul Cercueil <pcercuei@gmail.com>
Date: Sat, 19 Nov 2011 20:49:36 +0000
Subject: Dreamcast build broken
Message-Id: <4EC81660.3010109@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I've been trying to compile a Linux 3.1 vanilla kernel for my dreamcast, 
but the final binary fails to load on emulators and on the real hardware.
The config I'm using is the default one created with "make 
dreamcast_defconfig".

Is the dreamcast build broken or am I doing something wrong?
I tried to git-bisect the commit(s) which introduced the error, but not 
all kernels will build with GCC 4.5.2, I'll need a good number of 
different toolchains...

Regards,
Paul
