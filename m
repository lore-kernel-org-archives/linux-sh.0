From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 09 Jan 2014 17:23:25 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: Fix MSTP clock index
Message-Id: <52CEDB0D.3080608@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1388167599-23525-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388167599-23525-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/01/14 17:21, Ben Dooks wrote:
> On 27/12/13 18:06, Valentine Barshak wrote:
>> Use clkidx when registering MSTP clocks instead of loop counter
>> since the value is then used to access the specific clock index bit
>> in the mstp register.
>>
>> The issue was introduced by the following commit:
>> f94859c215b6d977 "clk: shmobile: Add MSTP clock support"
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> We just caught this one, it really needs fixing in Simon's tree
> as it stops stuff working!

sorry, meant to say:

Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
