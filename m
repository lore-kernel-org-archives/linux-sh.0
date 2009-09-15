From: Dale Larson <dlarson42@gmail.com>
Date: Tue, 15 Sep 2009 12:55:14 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909150555n77509af4qeab720883a7e9c44@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> I assumed SH7763 was an SH-X2 based core, but it turns out it is a
> first-generation SH-4A, in which case it does not implement the extended
> mode TLB. So the next available page size above 4k is 64k. I wasn't aware
> there was anyone still running first generation SH-4A, I'll have to dust
> some of mine off to see if I can reproduce your issues.

We're finally replacing our 7760 (yep, you heard right) based product
with the 7763.
While you're dusting your's off we'll just be putting polish on it. ;-)

> page size. That will bring up a menu where you can cycle through the
> available page sizes. I don't recommend 1MB for a system page size, as it
> tends to interact badly with some of the slab allocators. 64k will give
> you an idea of whether there are indeed any aliasing bugs lurking about.

I'll try that.

Thanks!
