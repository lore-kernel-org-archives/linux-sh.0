From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Dec 2008 07:30:36 +0000
Subject: Re: [Bug report] dead lock is occur in mutex_trylock
Message-Id: <20081208073036.GA14767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2008 at 04:17:17PM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Dear Paul
> 
> I noticed dead lock occur on latest linux-sh.git
> 
> It works well if I use old ${LINUX}/arch/sh/include/asm/mutex-llsc.h,
> But, latest mutex-llsc.h seems cause dead lock on __mutex_fastpath_trylock.
> 
> It confirmed on AP325 board.
> 
Do you have a test case that can reproduce this?
