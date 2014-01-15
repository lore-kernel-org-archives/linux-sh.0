From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 15 Jan 2014 10:27:06 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: lager: fix error return code check from clk_get()
Message-Id: <52D6627A.3060405@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389725007-5023-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389725007-5023-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 15/01/14 00:16, Simon Horman wrote:
> On Tue, Jan 14, 2014 at 06:43:26PM +0000, Ben Dooks wrote:
>> The lager_add_standard_devices() function calls clk_get() but then fails
>> to check that it returns an error pointer instead of NULL on failure.
>>
>> This was added by 4a606af2 ("ARM: shmobile: lager-reference: Instantiate
>> clkdevs for SCIF and CMT") patch in horms' renesas-boards2-for-v3.14~6
>> release.
>>
>> The issue is not serious as it does not cause a crash and seems to not be
>> actually causing any issues now the other clock bugs have been fixed.
>>
>> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Thanks, I have queued up the following:

Great, will try and re-test on a latest devel branch in the next
few days.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
