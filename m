From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 21 Jun 2013 08:17:24 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <201306211017.24308.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 21 June 2013, Magnus Damm wrote:
> > "the next best solution would be naming it
> > after the chip that first used a particular version of that IP block,
> > like "renesas,shmobile1234-sdhi". The device tree include file for
> > shmobile5678 should then list the sdhi part as being compatible with
> > the "reneasas,shmobile1234-sdhi" if they are the same, or as
> > a separate "reneasas,shmobile5678-sdhi" if they behave in a different
> > way."
>
> Thanks for the quote. I can now see clearly about shmoble5678 and shmobile1234.
> 
> I hate to be difficult, but I disagree. =)
> 
> Perhaps my logic is flawed, but if I understand the above then we are
> supposed to put DTS device nodes with compatible strings based on
> current driver behaviour?
> 
> I see one problem with that. Say that a certain new hardware feature
> is included in one SoC, but the driver does not yet implement it. And
> perhaps the driver developer does not understand the difference fully
> when the device node is added to the DTS. Then won't we end up in a
> situation where people may roll out DTBs in products and that would
> not allow us to enable the feature later in the driver with a software
> update? Now, if we always used shmobile5678 for shmobile5678 then we
> would never have any problems.

I said that you should use compatible="reneasas,shmobile1234-sdhi" if
it is the /same/ block as the one used in 5678. If the new one is
actually backwards compatible but has additional features (or may
have them but you are not sure), then I would always list both,
so 'compatible="reneasas,shmobile5678-sdhi", "reneasas,shmobile1234-sdhi",
"renesas,shmobile-sdhi";'.

You always start with the most specific model string (and in doubt
you can be very specific here, up to a minor stepping release) and
list the more generic strings to the end. 

This way you can have both: the driver only needs to match shmobile1234
if it doesn't use any of the newer features, but can check for
shmobile5678 if it wants to.

For chips that you don't already know about, it is not a big thing
anyway, you can always use the most recent SoC string in the device
tree and put that into the driver. However, we want to ideally
support future SoCs with an unmodified driver, and that can only
work if the future part claims compatibility with an older one.

Using the same logic of putting the older 'compatible' strings
into the DT for compatible parts at the time of the initial binding
is not a technical necessity but is done for consistency with the
way we have to do it later.

> Of course, I prefer to use a version number for the hardware IP block
> instead of the SoC. This since this is not a SoC property. But if we
> now must be using SoC compatible strings then I think we should do it
> in a sane way that would reduce or risk of shooting ourself it the
> foot.

Not sure I get this. Do you have to use the SoC identifier because
you don't have access to the hardware IP block version, or because
someone told you to? Using the hardware IP block version is defintely
preferred in my opinion.

	Arnd
