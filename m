From: "CHIKAMA Masaki" <masaki.chikama@gmail.com>
Date: Mon, 10 Nov 2008 13:34:03 +0000
Subject: Re: repeated oops under load on SH4 system
Message-Id: <fd0635d10811100534l436be20bu9788da031878604f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
In-Reply-To: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2008/11/10 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Nov 10, 2008 at 05:11:59PM +0900, Paul Mundt wrote:
>> On Mon, Nov 10, 2008 at 05:06:23PM +0900, Paul Mundt wrote:
>> > On Tue, Nov 04, 2008 at 09:31:44PM +0900, CHIKAMA Masaki wrote:
>> > > Hello all.
>> > >
>> > > I've got repeated oops message  under a load on kernel 2.6.26.7.
>> > > It happens once or twice per a week with the below message.
>> > >
>> > > >Unable to handle kernel paging request at virtual address dfff0700
>> > > >Unable to handle kernel paging request at virtual address dfff1000
>> > > >Unable to handle kernel paging request at virtual address dfff0a00
>> > >
>> > > I have been gotten this message from around kernel 2.6.23. I didn't
>> > > test before it.
>> > > My hardware is mach-landisk with attached .config.
>> > > The root file system is on nfs server.
>> > > Please let me know if  you need more information to investigating the problem.
>> > > Could somebody give me a hint to resolve the issue ?
>> > >
>> > > Thanks in advance.
>> > >
>> > This suggests you are getting a TLB miss on various fixmap entries. Based
>> > on your call chain, these are related to the cache colouring in the page
>> > copying. update_mmu_cache() specifically faults the translation in, so
>> > you should not be making it all the way up to the TLB miss handler in the
>> > first place. This points to something evicting the entry from the TLB
>> > during your copy, which while it is not something I have seen in
>> > practice, is interesting to know that it remains a possibility under
>> > other workloads. A simple but expensive fix for this would be blowing out
>> > the TLB and speculatively bumping up the UTLB replace boundary prior to
>> > pre-faulting the fixmap translation. I'll look at this some more over the
>> > next couple days and send you a patch for testing.
>>
>> Now I remember where I saw this before.. try this patch:
>>
>> http://marc.info/?l=linux-sh&m0400865707505&w=2
>>
>> There was never any feedback on it, and I was not able to reproduce the
>> issues.
>
> Updated version, against current git:

Thank you for your comment and patch.
I backport the patch to 2.6.26.7 and start the work that I have been.
I'll let you know in one or two weeks whether the patch fix my problem.

-- 
CHIKAMA Masaki
