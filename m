From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Jul 2012 10:58:15 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <CANqRtoR31RcD2r8WgjktZVJ8o9aGfVvX3xrMBX10iP4r9U+aBw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 4, 2012 at 7:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jul 04, 2012 at 07:41:09PM +0900, Magnus Damm wrote:
>
>> Right, so what's wrong with having a "select REGULATOR_FIXED_VOLTAGE"
>> on boards that make use of them? That seems to be the most
>> straightforward way to me.
>
> I tend to agree; as I've said several times now the only sensible
> options I see are:
>
>  - Add the selects per board.
>  - Just enable the fixed voltage driver whenever the regulator core is
>    enabled.
>
> Anything else seems silly.

Yeah.

>> Also, I know too little about the regulator subsystem, but to me it is
>> somewhat special that REGULATOR=n behaves differently than REGULATOR=y
>> and REGULATOR_DRIVER=n.
>
> What's happening is that the regulator API stubs itself out when it's
> not in use in order to avoid having lots of ifdefs every time anyone
> tries to use the API in generic code or drivers that get used on
> multiple platforms.  This is the same behaviour as gpiolib, it's a
> similar sort of utility API.

I very much prefer that way over the way I think I2C (at least used
to) require #ifdef magic.

> If the power on defaults for the system weren't suitable for whatever is
> being done you'd still have an issue even with the stubs but a lot of
> the time the main effect of the API is to allow drivers to do additional
> power optimisations.

I may misunderstand the situation, but I believe the issue here is
that the REGULATOR=n case works fine on the boards with smsc911x, but
it stops "working" whenever REGULATOR=y is turned on and
REGULATOR_DRIVER_FOOBAR=n. People probably enable regulators because
they want to use the PMIC (that most likely isn't hooked up to the
SMSC chip), but they get surprised to see the following SMSC error
message:

smsc911x: Driver version 2008-10-21
smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
smsc911x smsc911x.0: (unregistered net_device): couldn't get regulators -517
platform smsc911x.0: Driver smsc911x requests probe deferral

Cheers,

/ magnus
