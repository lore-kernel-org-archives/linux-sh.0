From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 17 Apr 2009 06:44:27 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49E8254B.50307@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> Have a look at the following presentation for more information about
> the standby modes on SuperH Mobile:
>
> http://www.celinuxforum.org/CelfPubWiki/ELC2009Presentations?action=AttachFile&do=view&target=Runtime-Power-Management-on-SuperH-Mobile-20090407.pdf
>
>   
I just completed something similar on our ST40 (with PMB enabled).
We put the DRAM in self refresh an after that we totally turn-off the 
SOC removing the power.
An external little micro has to detect the wakeup event and has to 
turn-on the SOC.
The bootloader "understands" linux is frozen in memory and jump directly 
on linux.

Internally we call that "hibernation on memory" and clearly it needs 
update in both linux/bootloader...
But from the device driver point of view this is a normal hibernation 
while for the main core this is a special 'boot'.

Currently as major change I did are in the TMU/PMB and some asm code to 
manage the "reboot".

Do you think there is something shareable?

Ciao
 Francesco
