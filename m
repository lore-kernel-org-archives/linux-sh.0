From: Adrian Bunk <bunk@kernel.org>
Date: Sat, 31 May 2008 20:22:39 +0000
Subject: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <20080531202239.GB7347@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org, hjl.tools@gmail.com, lethal@linux-sh.org
Cc: linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

cayman_defconfig fails to build with the following error
(using binutils 2.18.50.0.7):

<--  snip  -->

...
  LD      drivers/macintosh/built-in.o
  LD      drivers/media/common/tuners/built-in.o
  CC [M]  drivers/media/common/tuners/tuner-xc2028.o
  CC [M]  drivers/media/common/tuners/tuner-simple.o
  CC [M]  drivers/media/common/tuners/tuner-types.o
  CC [M]  drivers/media/common/tuners/mt20xx.o
  CC [M]  drivers/media/common/tuners/tda8290.o
  CC [M]  drivers/media/common/tuners/tea5767.o
  CC [M]  drivers/media/common/tuners/tea5761.o
  CC [M]  drivers/media/common/tuners/tda9887.o
  CC [M]  drivers/media/common/tuners/xc5000.o
  LD      drivers/media/common/built-in.o
...
  LD      drivers/media/built-in.o
sh64-linux-ld: sh3 architecture of input file `drivers/media/common/built-in.o' is incompatible with sh5 outputmake[3]: *** [drivers/media/built-in.o] Error 1

<--  snip  -->


Minimal example demonstrating the problem:

$ sh64-linux-ar rcs tmp.o
$ sh64-linux-ld -EL -r -o tmp2.o tmp.o
$ sh64-linux-ld -EL -r -o out.o tmp2.o 
sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
$ 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

