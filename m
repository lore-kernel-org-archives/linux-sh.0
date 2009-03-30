From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 30 Mar 2009 07:02:54 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49D06E9E.4000506@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus, Yoshii-san
> Francesco, can you convince yoshii-san why we should add support for
> an interpreter? =)
>   
I can try ;-)
Than: I would push the interpreter solution because it will allow us to 
be free in the future.
If all the issue on 'cache preload' 'interpreter-instruction' are 
resolved in 'one-shot' right now
 in the future for each new SOC we will have only to resolve 'what it 
has to be done' and not 'how'....
This simplifies our development flow because we don't have to rediscover 
the wheel with always the same
 issue.
I know the interpreter will not allow 'optimized code' but I think the 
suspend assembly code doesn't have
 to be fast, it has to be right and for this reason I think it has to be 
written one time for ever...
Moreover an assembly code SOC oriented can not be seen as 'general 
purpose' solution while the interpreter
 can be 'theoretically' used by everybody.
>   
>> But, I don't think we need even backward jump.
>> What we want is conditional wait and delay, isn't it?
>>
>> SH_PM_OP_WAIT_UNTIL_EQ(addr, value) while(read(addr)!=value)/*wait*/;
>> SH_PM_OP_WAIT_UNTIL_SET(addr, mask) while(!(read(addr)&mask))/*wait*/;
>> SH_PM_OP_WAIT_UNTIL_CLR(addr, mask) while(read(addr)&mask)/*wait*/;
>> SH_PM_OP_DELAY_LOOP(count) while(count--)/*wait*/;
>>     
>
> I wonder if we can make those opcodes fit with the current format?
> Maybe no. They look fine with me though, but I'm not sure about
> Francescos use case.
>   
Enough good also for me but with a little change just one is enough:

SH_PM_OP_WAIT_UNTIL_EQ(addr, mask, value) while((read(addr) & mask) != value); /*wait*/;

In this manner it doesn't matter what each bit does (in the same word 
some bits could be set and some other could be reset).
Regards
 Francesco
