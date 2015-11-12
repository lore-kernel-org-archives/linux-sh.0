From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 12 Nov 2015 15:04:27 +0000
Subject: Re: [PATCH v2 04/10] i2c: rcar: remove spinlock
Message-Id: <5644AA7B.6090802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hello.

On 11/12/2015 5:31 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> After making sure to reinit the HW and clear interrupts in the timeout
> case, we know that interrupts are always disabled in the sections
> protected by the spinlock.

    What about SMP? Spinlocks are mostly necessary for the SMP support, their 
tole isn't limited to disabling interrupts...

> Thus, we can simply remove it which is a
> preparation for further refactoring. While here, rename the timeout
> variable to time_left which is way more readable.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[...]

MBR, Sergei

