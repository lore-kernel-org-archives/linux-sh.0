From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 08 Jun 2010 04:31:25 +0000
Subject: Re: [PATCH 1/2] sh: Drop dependence for 29bit mode of
Message-Id: <4C0DC79D.1060607@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTim7PR--Y_fueeMtdvnVX8BUJZK0iwG-rModFYzK@mail.gmail.com>
In-Reply-To: <AANLkTim7PR--Y_fueeMtdvnVX8BUJZK0iwG-rModFYzK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Tue, Jun 08, 2010 at 11:00:13AM +0900, Nobuhiro Iwamatsu wrote:
>> When CONFIG_PMB enable, ITLB is not cleared by reset of watchdog timer.
>> This should use trigger_address_error().
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> The whole reason for the 29-bit dependence is that we have no way to
> trigger an address error reset in 32-bit mode. Have you even tested this?
> 

I tested 32bit mode on sh7785lcr.
When watchboot tigger reset was not used this board, I confirmed reset enterd.

Nobuhiro


