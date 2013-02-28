From: horseriver <june.tune.sea@gmail.com>
Date: Thu, 28 Feb 2013 17:16:35 +0000
Subject: what does this line mean?
Message-Id: <20130228171635.GA2496@debian.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



 here is a line in a shell script file :
  
   for filesize in '$(ls -l . | grep "^-" | awk '\''{print $5}'\'')' 

what is ^- ? it is shell grammar or options of grep command?

 
