From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2012 13:15:55 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <201203281315.55670.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328103920.24945.11255.sendpatchset@w520>
In-Reply-To: <20120328103920.24945.11255.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 28 March 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This prototype patch extends the sh7372 DT support with actual
> IRQ support. The heavy lifting is all done by the prototype patch
>  "[PATCH] sh: INTC IRQ domain and DT support prototype".
> 
> It is worth noting that we have 3 root interrupt controllers on
> sh7372 and to set the parent pointer to NULL we let the device
> tree point to itself as interrupt-parent. Seems a bit overly
> complex so perhaps it is not the right way forward.
> 
> All root interrupt controllers are using IRQ domains but their
> allocation is kept the same as the non-DT case to allow us to
> leave the demux code as-is without any modifications. So in
> the DT case INTCA, IRQ16L and IRQ16H are kept at their original
> IRQ positions. INTCS is allocated dynamically in case of DT
> and at a fixed location as usual for non-DT boards.
> 
> Anyone that wants to play with DT with interrupts on sh7372
> will need to include this patch. The INTC IRQ domain patch above
> needs further work which will delay the merge.
> 
> Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>

Hi Magnus,

I'm trying to find my way through your patches, but I still have
a little trouble figuring out how it all fits together.

My feeling is that the soc specific parts can be done better
if you generalize the interrupt controller bindings so that
you can describe the controller(s) as a single device, and
allow all the information that is now in the intc-*.c files
to be moved into device tree attributes to be parsed at boot
time, or from the translate() function of the interrupt controller
driver.

That feeling may of course be completely wrong. Do you have
a link to a data sheet describing how that controller actually
works, or can you explain what the various arrays are needed
for today, and how the various interrupt controllers you register
fit together?

	Arnd
