From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 09 Jul 2013 07:37:29 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
Message-Id: <201307090937.29805.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709054331.14007.66068.sendpatchset@w520>
 <20130709054359.14007.23619.sendpatchset@w520>
In-Reply-To: <20130709054359.14007.23619.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 09 July 2013, Magnus Damm wrote:
> +void __init __weak emev2_clock_init(void)
> +{
> +       /* in case legacy clocks are disabled then do nothing */
> +}

Nitpicking:

I don't like the __weak symbols too much, in general I prefer
doing either

	if (IS_ENABLED(CONFIG_SHMOBILE_CLOCKS)
		emev2_clock_init()

or using an inline alternative in the header file.

	Arnd
