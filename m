From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 10 Mar 2009 11:24:18 +0000
Subject: Re: [linux-pm] [PATCH] pm: rework includes, remove arch ifdefs V2
Message-Id: <20090310112418.GG1337@ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223080204.13536.67018.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed 2009-02-25 12:59:29, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch contains the following header file changes:
>  - remove arch ifdefs and asm/suspend.h from linux/suspend.h
>  - add asm/suspend.h to disk.c (for arch_prepare_suspend())
>  - add linux/io.h to swsusp.c (for ioremap())
>  - x86 32/64 bit compile fixes

Looks ok to me, but I did not test it. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
