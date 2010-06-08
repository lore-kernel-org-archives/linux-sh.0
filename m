From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Jun 2010 04:39:06 +0000
Subject: Re: [PATCH 1/2] sh: Drop dependence for 29bit mode of trigger_address_error()
Message-Id: <20100608043906.GD6376@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTim7PR--Y_fueeMtdvnVX8BUJZK0iwG-rModFYzK@mail.gmail.com>
In-Reply-To: <AANLkTim7PR--Y_fueeMtdvnVX8BUJZK0iwG-rModFYzK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 08, 2010 at 01:31:25PM +0900, Nobuhiro Iwamatsu wrote:
> Paul Mundt wrote:
> >On Tue, Jun 08, 2010 at 11:00:13AM +0900, Nobuhiro Iwamatsu wrote:
> >>When CONFIG_PMB enable, ITLB is not cleared by reset of watchdog timer.
> >>This should use trigger_address_error().
> >>
> >>Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> >
> >The whole reason for the 29-bit dependence is that we have no way to
> >trigger an address error reset in 32-bit mode. Have you even tested this?
> >
> 
> I tested 32bit mode on sh7785lcr.
> When watchboot tigger reset was not used this board, I confirmed reset 
> enterd.
> 
The reason we limited it to 29-bit was simply because it had no effect on
SDK7786 where the 0x8... mappings don't even exist until we manualy
establish them. However, if we toggle MMUCR.TI immediately prior to that
like your other patch does, we can likely generate a reset by the MMU.
I'll test it out on my SH7785LCR and SDK7786 and see how it goes.
