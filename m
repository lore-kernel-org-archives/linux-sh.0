From: Stuart MENEFY <stuart.menefy@st.com>
Date: Tue, 08 Dec 2009 13:14:00 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <4B1E5118.9000006@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Folks

Paul Mundt wrote:
> On Tue, Dec 08, 2009 at 02:01:26PM +0900, yoshii.takashi@renesas.com wrote:
>  zImage doesn't provide the way to know the location.
>  Check your kernel configuration file to know where it is.

This is the bit which is nasty. Because we don't use the parameters which
are part of the zImage header (head.S) which are still set up for x86,
the boot loader has to know where empty zero page will end up.

>  zImage's entry point is the top of the binary.

Are you sure, I thought was was the start?

>> Name: (Mode_flag?)
>> Address/size: empty_zero_page+0x18/long
>>
>>  This is not a part of boot ABI.
>>  In vmlinux, this field carries the value indicate 29bit/32bit.
>>
> Correct, this is the 32bit boot flag. It's provided as a hint to figure
> out whether the boot loader has entered from 32-bit boot or not.
> Presently we don't do anything with this however.

We intended this to be rather more than a hint. Because the transition
into SE mode is painful we always do it in the boot loader, and so the
boot loader can check whether the kernel it is loading was compiled
in expectation that SE would already be on.

The 'contract' between the boot loader and the kernel in this case also
has to include the state of the PMB. We did write something about this,
I'll see if I can dig it up...
