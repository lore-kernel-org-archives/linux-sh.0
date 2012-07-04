From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Jul 2012 10:41:09 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <CANqRtoR4iXFD=pB6or+jPrCUgp1E0xeGE77z_PjubCmaZsm-_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 4, 2012 at 7:38 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jul 04, 2012 at 12:40:56PM +0200, Rafael J. Wysocki wrote:
>
>> Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
>> and we can just make things depending on it depend on REGULATOR directly?
>
>> The meaning of what you're proposing above is pretty much
>> "REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is" and I guess
>> REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.
>
>> How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
>> when REGULATOR is set?
>
> No, that won't help - the problem is that we want a specific regulator
> driver to be built in order to ensure that the services it provides are
> available.

Right, so what's wrong with having a "select REGULATOR_FIXED_VOLTAGE"
on boards that make use of them? That seems to be the most
straightforward way to me.

Also, I know too little about the regulator subsystem, but to me it is
somewhat special that REGULATOR=n behaves differently than REGULATOR=y
and REGULATOR_DRIVER=n.

Thanks,

/ magnus
