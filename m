From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 13 May 2009 14:20:15 +0000
Subject: Re: [PATCH] sh: clkfw: Moved the .init callback in the	clk_register
Message-Id: <4A0AD71F.9050406@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Rebased on the latest git as suggested by Magnus.

Jean-Christophe PLAGNIOL-VILLARD ha scritto:
> On 14:27 Wed 13 May     , Francesco VIRLINZI wrote:
>   
>> This patch moves the .init callback in the clk_register function.
>> Moreover not the .init callback return a value:
>>  - zero means the initialization is ok and the clock can be registered.
>>  - any value not zero means there is a problem in the initialization and
>>    the clkfw rejects the clock registration
>>
>> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
>> ---
>>     
> what the diff against the precedent version?
>
> it will be nice if you can put here the update between each version
>
> Best Regards,
> J.
>
>   

