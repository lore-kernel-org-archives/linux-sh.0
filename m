From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 29 Jan 2014 08:03:00 +0000
Subject: Re: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <52E8B5B4.6060800@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 29/01/14 06:45, Simon Horman wrote:
> On Tue, Jan 28, 2014 at 10:53:31PM +0400, Valentine Barshak wrote:
>> This enables DMA bounce for PCI since the controller does
>> not support more than 2G PCI-AHB memory window.
>> The problems with DMA transfers can be observed when
>> setting 2G/2G user/kernel memory split model
>> (CONFIG_VMSPLIT_2G=y)
>> These patches help to avoid it.
>
> Are these patches compatible with other user/kernel splits?

PS, the bridge is only actually capable of seeing 1GiB of
RAM due to alignment issues in the window. You can have either
0x4..0x8 or 0x8..0xc but not /both/. If you open the window to
2GiB then you can see either 0x0..0x8 or 0x8..0xF range.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
