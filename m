From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 09 Jul 2013 21:07:03 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
Message-Id: <201307092307.03502.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <201307090937.29805.arnd@arndb.de>
 <CANqRtoTcqYxCTWRok4cuzRWbCBULxwGYhgPyiVH_FgxBLtx7SQ@mail.gmail.com>
In-Reply-To: <CANqRtoTcqYxCTWRok4cuzRWbCBULxwGYhgPyiVH_FgxBLtx7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 09 July 2013, Magnus Damm wrote:
> Sure, good idea. I plan on using the following if you don't mind:
> 
>          if (!IS_ENABLED(CONFIG_COMMON_CLK)
>                  emev2_clock_init()
> 

Yes, looks good.

	Arnd
