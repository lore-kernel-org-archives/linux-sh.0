From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 01 Feb 2009 13:50:26 +0000
Subject: Re: sh: Virtual Board or Real board? (was Re: [Qemu-devel] [PATCH
Message-Id: <4985A8A2.7040307@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090121090424.GC14537@linux-sh.org>
	<4977527A.70104@juno.dti.ne.jp>
	<200901211706.09350.paul@codesourcery.com>
	<497AAB40.7010608@juno.dti.ne.jp>
	<20090127004312.GC3835@linux-sh.org>
In-Reply-To: <20090127004312.GC3835@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, qemu-devel@nongnu.org, Takashi Yoshii <yoshii.takashi@renesas.com>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Paul Mundt wrote:
> On Sat, Jan 24, 2009 at 02:46:40PM +0900, Shin-ichiro KAWASAKI wrote:
>> Paul Brook wrote:
>>>> Now, I hope that we would reach a consensus about the spec of new standard
>>>> board for SH-4A.  SH7785LCR is a choice.  And, as Iwamatsu-san suggested, 
>>>> a
>>>> virtual generic board is another choice.  I'm not sure SH7785LCR's 
>>>> hardware
>>>> spec is available or not. (Does anyone know it?)  If it is, I push
>>>> SH7785LCR.  Otherwise, virtual board sounds good.
>>> I recommend against using a virtual board. It means you have to maintain 
>>> both qemu and a kernel port. The mips virtual board suffered exactly this 
>>> fate, and IIUC is likely to be removed fairly soon.
>> Thank you for your comment.  As you pointed out, we need to maintain kernel
>> config for virtual board.  SH-Linux developpers' help is important.
>> I guess we can expect Iwamatsu-san's help :)  And once Paul Mundt
>> supported special kernel configuration for QEMU-SH kindly.
>>
>>
>> I try to clarify the difference of real board and virtual board, as follows.
>>
>> * Real board
>>
>> - We can compare the emulated system with the real board.  The specification
>>  is not vague, and deffects can be investitated by comaparison.
>>
>> - No need to maintain kernel, and it can avoid the risk the maintenance
>>  work would be terminated, as Paul Brook pointed out.
>>
>>
>> * Virtual board
>>
>> - It decreases the number of supported boards, and avoid messy many board
>>  supports.  SuperH series have many CPU sub tyepes, and as number of
>>  supported CPU types increase, number of suppoted boards will increase.
>>  (Iwamatsu-san pointed it out.)
>>
> This depends roughly on the level of support you are looking for. You can
> use the generic machine vector with any CPU you want and simply stick
> with the on-chip peripherals without having to make any board
> modifications. This should be sufficient for the simple case, especially
> if you are interested in testing different CPUs, but will not help you if
> you are looking for more complete board support.
Thank you.  Your explanation clarifies the relation between purpose and
target board.  I guess Iwamatsu-san's purpose is not board emulation but
CPU. Then virtual board is suitable for it.

My current purpose is to utilize QEMU to analyze SH system behavior mainly
for debug purpose. (Performance analysis with QEMU is my interest also, but
I do not expect exact analysis result.)  Anyway, I'd like to compare QEMU-SH
system and real SH board to see what QEMU can do, and what QEMU cannot. Then
I wanted to complete R2D+ board emulation.  But R2D+ is obsolete now, and
SH7785LCR will be my next choice.


>> - It avoids rare peripheral support by QEMU.
>>  Sometimes embedded boards have rare peripheral on it.
>>     e.g.) RTL8139B (below Rev.C). on R2D+.
>>           http://lists.gnu.org/archive/html/qemu-devel/2008-12/msg00961.html
>>  If we make the virtual board have standard peripheral (e.g. RTL8139C),
>>  we can reuse peripheral implemenation qualified with other board for other
>>  CPU arch, and avoid messy many type peripheral support.
>>
>> I'm not sure if QEMU's policy exists or not for this kind of choice.
>>
>> We can support both of them in the future.  But I think it is important
>> to make consensus which should be the default and standard for QEMU-SH,
>> to decide to which we'll try to contribute.
>>
>> I'd like to your comments on them.
>>
>>From the kernel point of view, whether we add a new machine type for
> emulated boards or not doesn't really matter, it mostly depends on how
> people are going to be using it, and what level of change you are looking
> for. I will add as many defconfigs and boards as people want as long as
> there are users for them anyways.
> 
> Anyways, I think there is value in supporting both. Emulating real
> hardware is especially helpful if you want to compare and contrast the
> environment between emulation and an existing platform, as well as
> allowing people without access to real hardware to develop against the
> emulated environment with testing conducted on real hardware as it
> becomes available.

I agree.  Board-less software development is very powerful use case of
QEMU.  I thank to QEMU developers, and hope that SH developers would
enjoy it too, in near future.

> Real hardware on the other hand is quite restrictive, and there are a lot
> of interesting features and capabilities that exist on some boards/CPUs
> but not others, limiting the amount of testing that can be performed. If
> people want to provide a virtual board that is pretty feature heavy to
> try and help with regression testing and so on, that would also be pretty
> useful.
> 
> I wouldn't worry about it too much anyways. If there is something you are
> specifically interested on working on in QEMU, there is no real reason
> why we can't accomodate that in the kernel too, it just depends on the
> code changes you want. We do want people to experiment with both on a
> regular basis anyways, so I have no real interest in setting any sort of
> policy on this subject. ;-)

I see.  My current understanding is as follows.

 - Both virtual and real boards will provide benefit for SH software developers,
   in different ways.
 - There is no restriction to add sh-linux defconfigs for virtual board, because
   there exist some sh-linux users those who expect it. : e.g.) Iwamatsu-san 
 - Anyway, we need new board support for QEMU-SH, because R2D+ is obsolete.
   (I do not much about 'shix' board, but I guess it is obsolete too.)

Then I'll begin to consider on SH7785LCR board emulation.  If someone is working
on it, please let me know.  I'll try to help it, or consider on virtual board
to avoid duplicated work.

# Of course, more advices on this issue are welcome.


Regards,
Shin-ichiro KAWASAKI

