From: Dale Larson <dlarson42@gmail.com>
Date: Tue, 15 Sep 2009 13:16:26 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909150616k3a667fa6r1a1d9eaed0e4edd9@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 8:07 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Sep 15, 2009 at 07:55:14AM -0500, Dale Larson wrote:
>> > I assumed SH7763 was an SH-X2 based core, but it turns out it is a
>> > first-generation SH-4A, in which case it does not implement the extended
>> > mode TLB. So the next available page size above 4k is 64k. I wasn't aware
>> > there was anyone still running first generation SH-4A, I'll have to dust
>> > some of mine off to see if I can reproduce your issues.
>>
>> We're finally replacing our 7760 (yep, you heard right) based product
>> with the 7763.
>> While you're dusting your's off we'll just be putting polish on it. ;-)
>>
> That's actually good to know, it means we'll have to do more aggressive
> regression testing on first-generation SH-X parts (we tend to scale back
> regression testing efforts on older parts when there are no visible users
> of them on the current kernel). In any event, I'll give both the SH7780
> and SH7770 highlanders a go tomorrow and see how things go.. and if that
> doesn't work, I'm sure there's a 7763 lying around the office somwehere.
> ;-)
>
>> > page size. That will bring up a menu where you can cycle through the
>> > available page sizes. I don't recommend 1MB for a system page size, as it
>> > tends to interact badly with some of the slab allocators. 64k will give
>> > you an idea of whether there are indeed any aliasing bugs lurking about.
>>
>> I'll try that.
>>
>> Thanks!
>
> One other thing I forgot to mention is that you might also want to try a
> 4k page size with write-through caching enabled. This you can configure
> via System type -> Cache configuration.

At one point I did give that a try but the system refused to run. I didn't take
any time to investigate why that happened.

I'll try it again with this newer code.

Thanks!
