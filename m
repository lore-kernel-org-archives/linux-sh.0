From: Rob Landley <rob@landley.net>
Date: Fri, 25 Mar 2016 01:54:13 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56F49A45.2040408@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 03/23/2016 05:05 AM, Magnus Damm wrote:
> Hi Rich,
> 
> On Thu, Mar 17, 2016 at 12:24 PM, Rich Felker <dalias@libc.org> wrote:
>> One of my goals in taking on maintainership of arch/sh is to gradually
>> replace all of the hard-coded legacy board/subtype support with device
>> tree based board descriptions, and clean up the related board support
>> infrastructure in arch/sh to be more in line with how things are done
>> on other archs these days. However the ability to make and test these
>> changes depends on having some actual hardware to work with.
>>
>> I'm working on the J-Core (currently J2) open hardware revival of the
>> SH architecture and don't have any original SH hardware (except
>> perhaps embedded in old appliances). Does anyone have pointers (direct
>> add-to-cart'able links) to where SH dev boards are still available, or
>> even better, any old hardware lying around that's not being used that
>> you'd be willing to donate?
>>
>> I'm especially interested in getting an SH-X3 board since it seems to
>> be the only model with existing SMP support, and moving it over to
>> device tree would eliminate the need for keeping around the
>> non-device-tree SMP register_smp_ops and cross-core cache invalidation
>> infrastructure, which are low-hanging fruit for refactoring/cleanup.
>> But really anything would be great to have.
> 
> I have a couple of old SH boards that I can hook up to remote access
> for you if that would help. Probably sh775x-based ones and maybe also
> something with sh2a. Need to go through my old boxes in the attic to
> find more detail. =)
> 
> As for SH-X3, I recall seeing that board IRL at some point on the desk
> next to me, but it was pretty rare even at that time so I highly doubt
> you will have any luck finding it or any SMP capable SH SoC.
> 
> In the mean time, does the sh4 target in QEMU work in system emulator
> mode? I recall user space emulation could run busybox at least.

Sure, I have prebuilt system images for that even.

  http://landley.net/aboriginal/bin/system-image-sh4.tar.gz

Most recently tested with the 4.3 kernel, I think?

Rob

Rob
