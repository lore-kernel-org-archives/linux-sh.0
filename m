From: Ryan Mallon <ryan@bluewatersys.com>
Date: Wed, 09 Feb 2011 20:42:02 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <4D52FC1A.9090700@bluewatersys.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
	<20110209203900.GT27982@pengutronix.de>
In-Reply-To: <20110209203900.GT27982@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 02/10/2011 09:39 AM, Uwe Kleine-K=F6nig wrote:
> Hi Ryan,
>=20
> On Thu, Feb 10, 2011 at 09:21:14AM +1300, Ryan Mallon wrote:
>>> +int clk_enable(struct clk *clk)
>>> +{
>>> +	unsigned long flags;
>>> +	int ret =3D 0;
>>> +
>>> +	spin_lock_irqsave(&clk->enable_lock, flags);
>>
>> 	WARN_ON(clk->prepare_count =3D 0); ?
> This is added in patch 3/3

Ah, missed that. I still think that patch 3 should just be rolled into
patch 1. I don't see why we should add a new file in one patch and then
randomly add some warning code to it in another patch. It makes
reviewing harder for one thing :-).

~Ryan

--=20
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
