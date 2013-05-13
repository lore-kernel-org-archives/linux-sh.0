From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 13 May 2013 15:53:37 +0000
Subject: Re: [PATCH 09/14] ARM: mvebu: Remove init_irq declaration in machine description
Message-Id: <51910C81.5050501@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-10-git-send-email-maxime.ripard@free-electrons.com>
 <20130513151934.GM31290@titan.lakedaemon.net>
In-Reply-To: <20130513151934.GM31290@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Jason,

Le 13/05/2013 17:19, Jason Cooper a =E9crit :
> On Mon, May 13, 2013 at 11:44:08AM +0200, Maxime Ripard wrote:
>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>> specified") removed the need to explictly setup the init_irq field in
>> the machine description when using only irqchip_init. Remove that
>> declaration for mvebu as well.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-mvebu/armada-370-xp.c | 1 -
>>  1 file changed, 1 deletion(-)
>=20
> Maxime,
>=20
> Do do want the individual submaintainers to take these?  Or, send one
> branch to Arnd and Olof?  I'm fine with either one as any merge
> conflicts should be trivial.

I don't have a strong opinion on this one, I guess both will be fine.
Arnd, Olof, what do you prefer?

I'll probably have to send a v2 anyway, I forgot to remove the include
of the irqchip headers.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
