From: Dale Larson <dlarson42@gmail.com>
Date: Tue, 15 Sep 2009 12:20:27 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909150520n29f4a0d0gdb66a0eff18e4fa2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

>> The 7763 only supports 1K, 4K, 64K and 1M pages. Would a 64K page
>> yield any useful info?
> You can get 8kB pages by enabling extended mode TLB. But yes, 64k pages
> are fine too, if using the compat mode TLB.

I can? I don't see it in the 7763 hardware manual. I only see this in
the MMU section:

"This LSI has four instruction TLB (ITLB) entries and 64 unified TLB
(UTLB) entries. UTLB
copies are stored in the ITLB by hardware. A paging system is used for
address translation, with
four page sizes (1, 4, and 64 Kbytes, and 1 Mbyte) supported. It is
possible to set the virtual
address space access right and implement memory protection
independently for privileged mode
and user mode."

If 64K would work with "compat mode TLB" how do I turn it on?
