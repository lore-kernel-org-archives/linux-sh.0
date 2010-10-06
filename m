From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 06 Oct 2010 15:26:34 +0000
Subject: Re: [PATCH 00/08] ARM: Dynamic IRQ demux support
Message-Id: <AANLkTi=qmY2gUFwK8-kK2sf7WL-tmRjVgGgowWR0yYHC@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101006071731.28048.89938.sendpatchset@t400s>
	<AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
	<AANLkTinm+bJduJ+46eUb8TA_v644Ui6j+zeBUKegofY7@mail.gmail.com>
	<AANLkTimD=-W3Mfdhvdj_1EHWA9jCY8KMBvsC-COfEPpX@mail.gmail.com>
	<AANLkTim10exCZChSNq-jYHcxff3myp8oGkytpYd3=8Vt@mail.gmail.com>
In-Reply-To: <AANLkTim10exCZChSNq-jYHcxff3myp8oGkytpYd3=8Vt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 6, 2010 at 9:11 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 11:06 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Wed, Oct 6, 2010 at 10:58 PM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>> On Wed, Oct 6, 2010 at 7:06 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>> On Wed, Oct 6, 2010 at 3:17 PM, Magnus Damm <magnus.damm@gmail.com> wr=
ote:
>>>>> ARM: Dynamic IRQ demux support
>>>>>
>>>>> [PATCH 01/08] ARM: Move entry-header.S to asm/
>>>>> [PATCH 02/08] ARM: Move macros from entry-armv.S
>>>>> [PATCH 03/08] ARM: Make alignment_trap macro self-contained
>>>>> [PATCH 04/08] ARM: Convert __irq_svc and __usr_svc to macros
>>>>> [PATCH 05/08] ARM: Move the unwind header to entry-header.S
>>>>> [PATCH 06/08] ARM: Add setup_irq_stubs() function
>>>>> [PATCH 07/08] ARM: Add CONFIG_DEFAULT_IRQ_DEMUX
>>>>> [PATCH 08/08] ARM: Dynamic IRQ demux for SH-Mobile
>>>>>
>>>>
>>>> Hi Magnus,
>>>>
>>>> Just FYI, I had a patch months ago for this:
>>>>
>>>> http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
>>>>
>>>> Do you think that's a simpler way to go?
>>>
>>> Speaking of which, what is the status of your patch? =A0I see you
>>> reposted it on July 13, but I haven't seen any further feedback.
>>>
>>
>> I should have posted it in Russell's patch tracking system, yet not
>> merged in last cycle.
>>
>> Russell?
>
> Got his wrong email address, now corrected and post again.

If you don't mind, please cc me when you repost.

Thanks,
g.

>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
