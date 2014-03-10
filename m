From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 10 Mar 2014 11:10:56 +0000
Subject: Re: [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field
Message-Id: <531D9DC0.7020100@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
 <20140310105116.GG14999@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140310105116.GG14999@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/03/14 10:51, Mark Rutland wrote:
> On Fri, Mar 07, 2014 at 12:46:40PM +0000, Ben Dooks wrote:
>> Add comaptibiltiy for older device trees by checking to see if
>> the clock-indices property is there and falling back to the
>> older renesas,clock-indices field.
>
> Why are these two separate patches? This temporarily breaks
> compatibility.

Given I've not had time to change any of the device trees
for the renesas series it isn't currently an issue.

I left it separate to make it easier to remove once the changes
are through.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
