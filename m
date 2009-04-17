From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 17 Apr 2009 21:38:30 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <20090417213830.GG9111@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19:39 Fri 17 Apr     , Magnus Damm wrote:
> Hi Francesco,
> 
> On Fri, Apr 17, 2009 at 3:44 PM, Francesco VIRLINZI
> <francesco.virlinzi@st.com> wrote:
> > I just completed something similar on our ST40 (with PMB enabled).
> > We put the DRAM in self refresh an after that we totally turn-off the SOC
> > removing the power.
> > An external little micro has to detect the wakeup event and has to turn-on
> > the SOC.
> > The bootloader "understands" linux is frozen in memory and jump directly on
> > linux.
> >
> > Internally we call that "hibernation on memory" and clearly it needs update
> > in both linux/bootloader...
> > But from the device driver point of view this is a normal hibernation while
> > for the main core this is a special 'boot'.
> 
> Sounds a bit similar to U-standby mode on SuperH Mobile.
> 
> > Currently as major change I did are in the TMU/PMB and some asm code to
> > manage the "reboot".
> >
> > Do you think there is something shareable?
> 
> For boot loader, do you use upstream U-boot? That would be interesting to see.
no old u-boot version 1.3.1 with a diferrent implemntation as the actual SH4
Mainline support

Actually it will be nice to have it, I've this exact hardware design and wish
to do it we on a 7105.

Francesco do you have any patch or tree were we can take a look on it?

Best Regards,
J.
