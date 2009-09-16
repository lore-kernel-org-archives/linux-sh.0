From: Dale Larson <dlarson42@gmail.com>
Date: Wed, 16 Sep 2009 12:45:21 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909160545n4aaa8944vd2a283204f4e5e2b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> So basically it looks like there are two separate bugs here, one is an
> aliasing issue that we need to address separately, and this one appears
> to be slab corruption. Do you know roughly which previous kernel worked
> for you? If so, that at least gives us a starting point for comparison.

I never had Linux successfully running on the 7763. I do have Linux 2.6.28.2
running on the 7760 with no problems.

> In any event, given that this is a slab issue, this should likely be
> reported to kerneloops.org, then it's possible to see if there are others
> that end up with similar issues and similar callchains.

Ok.

Dale
