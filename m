From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 22 Jun 2011 07:18:50 +0000
Subject: Re: Fwd: sh:fixed issue in xchg_u32 function when val==r15.
Message-Id: <4E01975A.4000302@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 22/06/2011 9.05, Carmelo Amoroso wrote:
> ---------- Forwarded message ----------
> From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
> Date: 19 April 2011 18:28
> Subject: Re: sh:fixed issue in xchg_u32 function when val=r15.
> To: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>
> 
> 
> Hi Paul,
> Thanks for the suggestion.
> 
> Attached is the reworked patch for potential gUSA rollback users.
> 
> Thanks,
> srini
> 
> 
> Paul Mundt wrote:
>>
>> On Thu, Apr 07, 2011 at 01:57:09PM +0100, Srinivas KANDAGATLA wrote:
>>
>>>
>>> Recently we have discovered a bug in xchg_u32 function of GUSA_RB feature.
>>> This function breaks if one of the input parameter 'val' is r15.
>>>
>>>    168:    02 c7           mova    174 <exit_mm+0x54>,r0
>>>    16a:    09 00           nop       16c:    f3 61           mov    r15,r1
>>>    16e:    fc ef           mov    #-4,r15
>>>
>>
>> The -4 here is part of the gUSA login sequence, so if you're seeing the
>> problem with gUSA based xchg_u32 it seems like you're going to have to
>> apply the same fix for all gUSA rollback users.
>>

Hi Paul, Srini
instead of making 'val' an input/output contraint (to force gcc not
using r15 directly), should not be better (or more correct) to add r15
to the clobbered register list ? r15 is actually modified for the
login/logout gUSA sequence.
Indeed, 'val' is not an output parameter... so we are benefiting from a
side effect.

Further, looking at __cmpxchg_u32, we think that we should make the
first argument (volatile int *m) an input/output constraint as well (as
it happens in xchg_u8 and xchg_32), and include r15 instead in the
clobber list, keeping 'val' just an input parameter.

Comments are welcome.

Cheers,
Carmelo & Salvo

