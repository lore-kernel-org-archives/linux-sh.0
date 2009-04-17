From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Apr 2009 10:39:50 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30904170339u514d68ddt9364ceabcb1f1955@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco,

On Fri, Apr 17, 2009 at 3:44 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> I just completed something similar on our ST40 (with PMB enabled).
> We put the DRAM in self refresh an after that we totally turn-off the SOC
> removing the power.
> An external little micro has to detect the wakeup event and has to turn-on
> the SOC.
> The bootloader "understands" linux is frozen in memory and jump directly on
> linux.
>
> Internally we call that "hibernation on memory" and clearly it needs update
> in both linux/bootloader...
> But from the device driver point of view this is a normal hibernation while
> for the main core this is a special 'boot'.

Sounds a bit similar to U-standby mode on SuperH Mobile.

> Currently as major change I did are in the TMU/PMB and some asm code to
> manage the "reboot".
>
> Do you think there is something shareable?

For boot loader, do you use upstream U-boot? That would be interesting to see.

Apart from that, this approach is low on my list. This because it
affects a lot of code and it may be difficult to maintain. I want to
prioritize R-standby where we can power off most of the CPU but still
resume from RAM without boot loader modifications... Do you have a
mode similar to R-standby?

Thanks for your offer!

/ magnus
