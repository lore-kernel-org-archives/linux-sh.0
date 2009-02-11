From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Wed, 11 Feb 2009 12:28:05 +0000
Subject: Re: [Qemu-devel] Status of SH4 support in repository
Message-Id: <4992C455.8020707@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090209172352.cae23097.kristoffer.ericson@gmail.com>	<4991B119.9060500@juno.dti.ne.jp>
	<20090210182909.b0dcab10.kristoffer.ericson@gmail.com>
In-Reply-To: <20090210182909.b0dcab10.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Kristoffer Ericson wrote:
> On Wed, 11 Feb 2009 01:53:45 +0900
> Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> wrote:
> 
>> Hi, Kristoffer.
>>
>> Kristoffer Ericson wrote:
>>> Greetings,
>>>
>>> Just interested in an update of the current status. I built a fresh qemu from
>>> the repository today and Im currently I get no output. 
>> I do not catch 'no output' mean.  Could you explain it more?
>>
>> FYI, here's the log how I built qemu-sh at Feb. 6th.
>>   http://www.assembla.com/wiki/show/qemu-sh4/BuildingEnvironment
> 
> My mistake I did something wrong when I built it earlier, currently
> it works somewhat. What doesnt work is keyboard,mouse and booting
> from image file (seems like to bootstring isnt being aknowledged).

Current qemu sh4 system emulation does not support either usb host
or kernel boot command line.  You still need to apply some patches
to use those features.

Please check qemu-sh patch staging repository, which holds patches
for qemu-sh. README in it explains how to apply.
  http://git.kernel.org/?p=virt/qemu/lethal/qemu-sh.git;a=summary
To apply all them, you need to role back qemu to rev 6215, for now.


The patch for usb host is already posted to qemu-ml.  But I guess
patch for kernel boot command line for r2d is not yet posted.
Does anyone know who wrote the patch in qemu-sh staging repository?


Regards,
Shin-ichiro KAWASAKI
