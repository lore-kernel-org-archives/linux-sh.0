From: horse <june.tune.sea@gmail.com>
Date: Sat, 02 Mar 2013 23:27:29 +0000
Subject: what does this do?
Message-Id: <20130302232729.GA2491@debian.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


  here are a portion of  build-in asm code  :

    "  .long 661b\n"              	\
    "  .long 663f\n"	    	\
    "  .byte %c0\n"             /		\
    "  .byte 662b-661b\n"       		\
    "  .byte 664f-663f\n"       

what is 661b ,etc ,what does it mean?

thanks!
