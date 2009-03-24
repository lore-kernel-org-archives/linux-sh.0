From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 24 Mar 2009 13:41:10 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49C8E2F6.3080703@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> Right, I understand. This becomes a bit more complicated but it's not
> so strange. As long as the two pass setup() is ok (first pass without
> buffer) then I'm ok.
>
> But do we (you!) really need to jump forward?
>   
Not really but I'd like to have no constraint if possible
>   
>> And with an ADD or a SUB instruction also some delay can be built on top of
>> these instructions.
>>     
>
> The opcode SH_PM_OP_ADD_IMM_R0 isn't enough?
>   
Yes I think so.

Have you time to extend your code or is it ok for you if I do the 
required update?

Regards
 Francesco
