From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 14:46:05 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <CABYn4swY_+fh6492DOsSBiCMGH9W_iWSjPOK77W244Ry4pv3Yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
 <1335960145.10293.48.camel@sauron.fi.intel.com>
 <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
 <1335966905.10293.59.camel@sauron.fi.intel.com>
 <CABYn4sz-_VCLUExgT7Bzr_mLCeYEnCV7ayhWCpkcH_2HyVFgjQ@mail.gmail.com>
 <1335967727.10293.63.camel@sauron.fi.intel.com>
 <CABYn4sxfw_qucyHK5Cj_yaM9yFKQQ24SCUJu2AcugXSzCbEYZw@mail.gmail.com>
In-Reply-To: <CABYn4sxfw_qucyHK5Cj_yaM9yFKQQ24SCUJu2AcugXSzCbEYZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

2012/5/2 Bastian Hecht <hechtb@googlemail.com>:
> 2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
>> On Wed, 2012-05-02 at 16:00 +0200, Bastian Hecht wrote:
>>> 2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
>>> > On Wed, 2012-05-02 at 15:41 +0200, Bastian Hecht wrote:
>>> >> Ok I'm slowly but surely fighting my way through it. Though I want to
>>> >> add an advisor here:
>>> >> Don't do this on your crappy laptop like I do. I guess I will move to
>>> >> my 8Gb RAM desktop machine for this in the future ;)
>>> >
>>> > Yeah, I run it on a powerful PC. I need to update the README file - but
>>> > if you send a patch - will be appreciated.
>>>
>>> I assumed people to be smarter than me and instantly realize that a
>>> compile-test is resource intensive, so I'm unsure if this is
>>> necessary.
>>
>> You are not the first one :-)
>
>
> Now I'm really stuck. The verbose log says the build target "all"
> failed. When I used -p to keep the clone and used make ARCH=arm
> CROSS-...=... l2_mackerel_defconfig; make ARCH=... CROSS=... all -
> everything builds fine.
>
> command used: ../aiaiai/concat-mbox-files /tmp/patch/* |
> ../aiaiai/test-patchset -j8 -p -v ../flctl_patch/ --cppcheck --sparse
> l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-
>
> The log looks like this:
> HEAD is now at 07126b9 for test compiling
> [2012-05-02 15:51:43] test-patchset: Build non-patched kernel
> ("/tmp/test-patchset.IxuP/before/src", configuration
> "l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-")
> mkdir: created directory
> `/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-'
> [2012-05-02 15:51:43] make-kernel: Making target
> "l2_mackerel_defconfig" for "/tmp/test-patchset.IxuP/before/src
> (O=/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-)"
> [2012-05-02 15:51:49] make-kernel: Making target "all" for
> "/tmp/test-patchset.IxuP/before/src
> (O=/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-)"
> [2012-05-02 15:52:16] make-kernel: Failed to make target "all" for
> "/tmp/test-patchset.IxuP/before/src
> (O=/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-)"
> [2012-05-02 15:52:16] make-kernel: Failed to make a target, exiting


What I forgot to mention is:

The error log l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-.stderr.log
states:
...
...
make: *** [sub-make] Error 2
FAILURE

but in the whole log there is no error listed. It only appears at the
end without any references.

>
>> --
>> Best Regards,
>> Artem Bityutskiy
