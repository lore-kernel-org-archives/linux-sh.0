From: Simon Horman <horms@verge.net.au>
Date: Sun, 11 May 2014 00:46:27 +0000
Subject: Re: [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <20140511004626.GW31760@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWwenyU1RS4c8spFcb7M0oCXP9z8zbGQ0VACKj7EbvvkA@mail.gmail.com>
In-Reply-To: <CAMuHMdWwenyU1RS4c8spFcb7M0oCXP9z8zbGQ0VACKj7EbvvkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, May 08, 2014 at 12:12:29PM +0200, Geert Uytterhoeven wrote:
> On Tue, May 6, 2014 at 11:26 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Tested on Koelsch (legacy, reference, shmobile, and shmobile+bbb kernels)
> > and BeagleBone Black (shmobile+bbb). Will test on more hardware tomorrow.
> 
> Tested on genmai with Wolfram's CCF support.

Thanks, shall I go ahead and queue this up?
