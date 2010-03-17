From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 11:15:29 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003170415g42d7e566n2ff9ed7d230a8e7f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 17, 2010 at 8:11 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Is it accessible by me for example
> git://git.kernel.org/pub/scm/linux/kernel/git/magnus/sh-2.6.git
>
> or not?

You don't need any speical tree or patches. The normal sh-2.6 tree
should include all you need. Please try using the same commands as me
below:

Check last commit in git branch/tree:

damm@t400s ~/git/sh-2.6 $ git log -1 --oneline | head -n 1
3f7581d serial: sh-sci: remove duplicated #include

Look for board support:

damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO
arch/sh/boards/mach-rsk/devices-rsk7203.c
       .flags          = SMSC911X_USE_32BIT | SMSC911X_SWAP_FIFO,

Look for driver support:

damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO drivers/net/smsc911x.c
       if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
       if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
damm@t400s ~/git/sh-2.6 $

Cheers,

/ magnus
