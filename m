From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 06 Mar 2009 05:05:22 +0000
Subject: Re: [PATCH/for-2.6.29] sh: Add media/soc_camera.h to board setup of
Message-Id: <49B0AF12.80004@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B08FA2.30007@renesas.com>
In-Reply-To: <49B08FA2.30007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, Mar 06, 2009 at 11:51:14AM +0900, Nobuhiro Iwamatsu wrote:
>> Other compilation errors were revised by commit of
>> "sh: ap325rxa: Revert ov772x support"
>> (08c2f5b4d76f83213e379b12df504269d21c9e7c) but other compilation
>> errors are given.
>> We revert this commit and need to add new header(media/soc_camera.h).
>> This change revises new compilation error.
>>
> What was the build you error you saw? I built the defconfig and did not
> run in to any issues.
> 
Oops, sorry. I mistook.
Please ignore this patch.

Best regards,
  Nobuhiro
