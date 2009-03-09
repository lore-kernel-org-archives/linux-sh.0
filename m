From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 09 Mar 2009 10:03:46 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B4E982.4060107@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

I'm sorry if I'm stressing you but you will have similar problem also 
with the clock framework.
A simple
 -  clk_get_rate(...)
could return a wrong value if in the previous session someone changed 
the clock rate (from init value) and
 you don't force again in the hw the resumed "clk->rate".

Regards
 Francesco

>> If you use a "mini-kernel" with several modules... when you will resume from
>> hibernation at the begin
>> you boots again the 'mini-kernel'... after that you restore the previous
>> image and the irq line required by
>> module more probably remains as it was (not-initialized).
>>     
>
> Ok, good point. I'll add intc suspend/resume to my todo list!
>
> Thanks!
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

