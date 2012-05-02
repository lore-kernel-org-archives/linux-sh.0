From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 14:00:12 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <CABYn4sz-_VCLUExgT7Bzr_mLCeYEnCV7ayhWCpkcH_2HyVFgjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
 <1335960145.10293.48.camel@sauron.fi.intel.com>
 <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
 <1335966905.10293.59.camel@sauron.fi.intel.com>
In-Reply-To: <1335966905.10293.59.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
> On Wed, 2012-05-02 at 15:41 +0200, Bastian Hecht wrote:
>> Ok I'm slowly but surely fighting my way through it. Though I want to
>> add an advisor here:
>> Don't do this on your crappy laptop like I do. I guess I will move to
>> my 8Gb RAM desktop machine for this in the future ;)
>
> Yeah, I run it on a powerful PC. I need to update the README file - but
> if you send a patch - will be appreciated.

I assumed people to be smarter than me and instantly realize that a
compile-test is resource intensive, so I'm unsure if this is
necessary.

>> There's only 1 thing I don't completely grasp: you pass a target path
>> to aiaiai/test-patchset and a working tree. I didn't manage to get it
>> take the l2_mackerel_defconfig from one and compile the patches on top
>> of the other.
>
> Yeah, this is in my TODO list to teach aiaiai to take defconfig files
> which are not part of the tree. So you basically need to copy the
> l2-mackerel_defconfig file to your tree and commit it, so that the
> defconfig is part of the git tree you are testing against.
>
> But I want to teach test-patchset to accept just stand-along defconfig
> files.
>
> The reason it is implemented the way it is implemented because it was
> originally done for an internal project where we have a couple of
> defconfigs which are part of the project tree.
>
>> =A0So I simply copied the defconfig to my kernel dir and
>> ran the command manually.
>
> You should also commit it, of course. Because the way aiaiai works it
> first clones your tree and then work with the clone. This is done to
> make sure your tree is preserved intact.
>

Ok, then I completely understood the concept. In fact I did commit the
defconfig after I used verbose output and saw the clones of the trees.
But I must admit that I'm still struggling to get the same warnings
from your post. But I'll manage I guess.

> --
> Best Regards,
> Artem Bityutskiy
