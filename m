From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 14 May 2013 08:23:20 +0000
Subject: Re: [PATCH 05/14] ARM: shmobile: Remove init_irq declaration in machine description
Message-Id: <5191F478.4040800@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-6-git-send-email-maxime.ripard@free-electrons.com>
 <20130514003504.GE12228@verge.net.au>
In-Reply-To: <20130514003504.GE12228@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Le 14/05/2013 02:35, Simon Horman a =E9crit :
> On Mon, May 13, 2013 at 11:44:04AM +0200, Maxime Ripard wrote:
>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>> specified") removed the need to explictly setup the init_irq field in
>> the machine description when using only irqchip_init. Remove that
>> declaration for shmobile as well.
>=20
> Hi Maxime,
>=20
> If possible, I would prefer separate patches for each board and SoC.

Ok, I'll split this and send it in the v2.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
