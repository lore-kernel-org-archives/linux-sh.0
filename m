From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Feb 2014 10:27:01 +0000
Subject: Re: [PATCH 3/3] clk-mstp: add backwards comapt for indicies field
Message-Id: <52FDEF75.2040200@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/02/14 23:15, Laurent Pinchart wrote:
> Hi Ben,
>
> Thank you for the patch.
>
> On Thursday 13 February 2014 18:02:51 Ben Dooks wrote:
>> Add comaptibiltiy for older device trees by checking to see if
>> the clock-indicies property is there and falling back to the
>> older renesas,clock-indices field.
>
> I would drop this patch. The Renesas clocks DT bindings are too new (v3.14-
> rc1, and for multiplatform kernels only) to be considered as stable in my
> opinion.

Ok, Magnus earlier was all in favour of not breaking things.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
