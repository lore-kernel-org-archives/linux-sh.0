From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 15 Apr 2014 11:43:28 +0000
Subject: Re: Renesas clock clk-mstp updates for clock-indices
Message-Id: <534D1B60.8030007@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
In-Reply-To: <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 15/04/14 10:26, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Fri, Mar 7, 2014 at 1:46 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> Mike, following the commit to add the clock-indices field, the following
>> pair of commits updates the shmboile clk-mstp driver to uses these over
>> the local variant.
>>
>> Since this is involves two separte trees which are in development, the
>> decision is that we will fixup the renesas trees once they are merged
>> and the development cycle is complete. Once this is done, patch 2/2
>> can be reverted (if people care about three lines of differrence)
>
> As we now have "renesas,clock-indices" in v3.14, the question about backwards
> compatibility became moot.

Do you mean 'necessary'?

> Can you please combine your two patches
>
> [PATCH 1/2] clk: shmobile: clk-mstp: change to using clock-indices
> [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field
>
> into a single patch, and submit to Mike?
>
> Once it's in Mike's clk-next, we can do the following to get everything in
> v3.15:
>    1. Simon cherry-picks Mike's commit into his fixes-for-v3.15 branch,
>    2. we fix arch/arm/boot/dts/r8a7790.dtsi and .../r8a7791.dtsi there,
>    3. fixes-for-v3.15 gets into mainline through arm-soc.

Wouldn't it be easier if we just got mike's ack and fixed it in one go?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
