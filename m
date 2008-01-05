From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 05 Jan 2008 01:09:46 +0000
Subject: Busybox and automatic module loading
Message-Id: <1199495386.12780.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am struggling to get alsa (userland) to work on my Dreamcast - the
kernel side works nicely when using oss emulation but I cannot get the
pure alsa stuff - which relies on the alsa-lib - to work at all.

I *think* this is due to not being able to configure the modules
automatically and I cannot figureout any way to get Busybox to do this -
eg neither /etc/modules or /etc/modules.conf appear to be handled.

I suppose I could hack the init in some way to fix this, but I wonder if
someone here has had this problem and knows how to get round it?

Adrian

