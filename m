From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Thu, 23 Jun 2011 13:17:45 +0000
Subject: Re: Fwd: sh:fixed issue in xchg_u32 function when val==r15.
Message-Id: <4E033CF9.3000205@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E01975A.4000302@st.com>
In-Reply-To: <4E01975A.4000302@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23/06/2011 14.27, Srinivas KANDAGATLA wrote:
> Hi Carmelo & Salvo,
> I agree with your observation..
> 
> Initially we had similar understanding, however after discussing with
> compiler guys and reading
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id807  posts, which made us
> decide adding 'val' to constraints rather than clobber list.
> As r15 is the stack pointer, adding r15(SP) to clobber list might not
> work as expected(as we have no idea what compiler is going to do), One
> guess is that It will have unknown side effects(which is proved as shown
> below...).
> 
> Yesterday, Stuart and I spend some time to test and see the side-effect
> of adding r15 to clobber list in xchg_u32 after reverting my changes on
> 7141(ST40) board, We got lucky.. and encountered crash in every boot.
> 
> PC and PR ended up at 0x0 as r15 got corrupted because of the below code
> generated as result of r15 in clobber list.
> 
> 
> 0x8004b128 <+36>: mova 0x8004b134 <bdi_sync_supers+48>,r0
> 0x8004b12a <+38>: nop
> 0x8004b12c <+40>: mov r15,r1
> 0x8004b12e <+42>: mov #-4,r15
> 0x8004b130 <+44>: mov.l @r2,r3
> 0x8004b132 <+46>: mov.l r8,@r2
> 0x8004b134 <+48>: mov r1,r15
> 0x8004b136 <+50>: jsr @r10
> 0x8004b138 <+52>: nop
> 0x8004b13a <+54>: jsr @r9
> 0x8004b13c <+56>: nop
> 0x8004b13e <+58>: jsr @r11
> 0x8004b140 <+60>: nop
> 0x8004b142 <+62>: tst r0,r0
> => 0x8004b144 <+64>: bt.s 0x8004b124 <bdi_sync_supers+32>
> => 0x8004b146 <+66>: lds.l @r15+,pr
> 0x8004b148 <+68>: mov.l @r15+,r11
> 0x8004b14a <+70>: mov #0,r0
> 0x8004b14c <+72>: mov.l @r15+,r10
> 0x8004b14e <+74>: mov.l @r15+,r9
> 0x8004b150 <+76>: rts
> 
> 
> If you look at the highlighted lines of code, bt is delayed branch
> instruction, which ends up incrementing r15 for every loop, as a result
> we see PC and PR end's up at 0.
> 
> with latest code (with my patches) below code is generated for the same
> subroutine.
> 298: 02 c7 mova 2a4 <bdi_sync_supers+0x34>,r0
> 29a: 09 00 nop
> 29c: f3 61 mov r15,r1
> 29e: fc ef mov #-4,r15
> 2a0: 22 67 mov.l @r2,r7
> 2a2: 32 22 mov.l r3,@r2
> 2a4: 13 6f mov r1,r15
> 2a6: 0b 49 jsr @r9
> 2a8: 09 00 nop
> 2aa: 0b 48 jsr @r8
> 2ac: 09 00 nop
> 2ae: 0b 4b jsr @r11
> 2b0: 09 00 nop
> 2b2: 08 20 tst r0,r0
> => 2b4: ec 89 bt 290 <bdi_sync_supers+0x20>
> => 2b6: 26 4f lds.l @r15+,pr
> 2b8: f6 6b mov.l @r15+,r11
> 2ba: 00 e0 mov #0,r0
> 2bc: f6 6a mov.l @r15+,r10
> 2be: f6 69 mov.l @r15+,r9
> 2c0: 0b 00 rts
> 
> 
> There might be other such instances of side effects of r15(stack
> pointer) in clobber list.
> I hope we answered why 'val' ended up in input/output constraints rather
> than r15 in clobber list.
> 
> Thanks,
> srini
> 

Hi Srini,
yes this clarified the reason. What about adding the same constraint to
'm' as well. I understand there are not failures up to now, but it could
happen as well.

Cheers,
Carmelo


> Carmelo AMOROSO wrote:
>> On 22/06/2011 9.05, Carmelo Amoroso wrote:
>>> ---------- Forwarded message ----------
>>> From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
>>> Date: 19 April 2011 18:28
>>> Subject: Re: sh:fixed issue in xchg_u32 function when val=r15.
>>> To: Paul Mundt <lethal@linux-sh.org>
>>> Cc: linux-sh@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>
>>>
>>>
>>> Hi Paul,
>>> Thanks for the suggestion.
>>>
>>> Attached is the reworked patch for potential gUSA rollback users.
>>>
>>> Thanks,
>>> srini
>>>
>>>
>>> Paul Mundt wrote:
>>>> On Thu, Apr 07, 2011 at 01:57:09PM +0100, Srinivas KANDAGATLA wrote:
>>>>
>>>>> Recently we have discovered a bug in xchg_u32 function of GUSA_RB
>>>>> feature.
>>>>> This function breaks if one of the input parameter 'val' is r15.
>>>>>
>>>>>    168:    02 c7           mova    174 <exit_mm+0x54>,r0
>>>>>    16a:    09 00           nop       16c:    f3 61           mov   
>>>>> r15,r1
>>>>>    16e:    fc ef           mov    #-4,r15
>>>>>
>>>> The -4 here is part of the gUSA login sequence, so if you're seeing the
>>>> problem with gUSA based xchg_u32 it seems like you're going to have to
>>>> apply the same fix for all gUSA rollback users.
>>>>
>>
>> Hi Paul, Srini
>> instead of making 'val' an input/output contraint (to force gcc not
>> using r15 directly), should not be better (or more correct) to add r15
>> to the clobbered register list ? r15 is actually modified for the
>> login/logout gUSA sequence.
>> Indeed, 'val' is not an output parameter... so we are benefiting from a
>> side effect.
>>
>> Further, looking at __cmpxchg_u32, we think that we should make the
>> first argument (volatile int *m) an input/output constraint as well (as
>> it happens in xchg_u8 and xchg_32), and include r15 instead in the
>> clobber list, keeping 'val' just an input parameter.
>>
>> Comments are welcome.
>>
>> Cheers,
>> Carmelo & Salvo
>>
> 
> 

