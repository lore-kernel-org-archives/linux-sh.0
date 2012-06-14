From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 14 Jun 2012 16:15:59 +0000
Subject: Re: [PATCH v2] lib/decompress_unxz.c: removing all memory helper functions
Message-Id: <4FDA0E3F.3030603@zytor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <4FD6B472.7040609@zytor.com> <20120612143545.GC7918@n2100.arm.linux.org.uk>
 <20120614134715.GE28714@n2100.arm.linux.org.uk> <4FD9F6AD.6060407@zytor.com>
 <20120614154414.GA7628@n2100.arm.linux.org.uk>
In-Reply-To: <20120614154414.GA7628@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/14/2012 08:44 AM, Russell King - ARM Linux wrote:
>>>
>>> Okay, given the issue raised with memcpy() calling __builtin_memcpy(),
>>> I don't think there's any value to me actually testing this, because
>>> that seems to need to be solved first?
>>
>> You mean __builtin_memcpy() calling memcpy(), right?
> 
> Indeed I do.

Right... that would manifest itself as a build failure, but it needs to
be fixed, so...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

