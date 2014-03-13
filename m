From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Mar 2014 11:35:01 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <532197E5.6000305@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/03/14 11:27, Geert Uytterhoeven wrote:
> Hi Laurent,
>
> On Wed, Mar 12, 2014 at 10:04 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>> The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
>> bit value should thus be inverted in the is_enabled() operation.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>>   drivers/clk/shmobile/clk-mstp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Geert, I believe this patch should fix the problem we've noticed with
>> clk_disable_unused() not disabling unused clocks. Could you please test it ?
>
> Yes, now it disables the hardware clock bits for all clocks that are not in
> use according to CCF:

Do you have the drivers/sh fix in?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
