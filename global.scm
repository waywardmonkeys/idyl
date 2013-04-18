;; ---------------------------------------------------------------------- ;;
;; FICHIER               : global.skel                                    ;;
;; DATE DE CREATION      : Mon May 29 09:47:02 1995                       ;;
;; DERNIERE MODIFICATION : Mon May 29 09:47:40 1995                       ;;
;; ---------------------------------------------------------------------- ;;
;; Copyright (c) 1995 Dominique Boucher                                   ;;
;; ---------------------------------------------------------------------- ;;
;; This file contains all the primitive functions and classes             ;;
;; definitions.                                                           ;;
;; ---------------------------------------------------------------------- ;;

(define (startup-file) "/home/dboucher/lib/idyl/startup.dylan")

(define (install-predef! gf proc)
  (proc gf (generic-code (instance-slots gf))))

;; --- Les variables de base du MOP ------------------------------------- ;;
(define <object> #f)
(define <type>   #f)
(define <class>  #f)

;; ---------------------------------------------------------------------- ;;
;; Initialisation du protocole m�taobjet (MOP) ...                        ;;
;; ---------------------------------------------------------------------- ;;
(define (init:mop)
  (set! <object>   
	(make-instance 
	 #f 
	 (make-class '<object> #f #f #f #f '() '() '() '() '() '())))
  (set! <type>
	(make-instance 
	 #f 
	 (make-class '<type> #f #f #f #f (list <object>) '() '() '() '() '())))
  (set! <class>
	(make-instance 
	 #f
	 (make-class '<class> #f #f #f #f (list <type>) '() '() '() '() '())))
	
  (instance-class-set! <object> <class>)
  (instance-class-set! <type> <class>)
  (instance-class-set! <class> <class>)
  
  (class-prec-list-set! (instance-slots <object>) (list <object>))
  (class-prec-list-set! (instance-slots <type>)   (list <type> <object>))
  (class-prec-list-set! (instance-slots <class>)  (list <class> <type> <object>))

  (class-direct-subs-set! (instance-slots <type>)   (list <class>))
  (class-direct-subs-set! (instance-slots <object>) (list <type>))
  
  )
  
;; ---------------------------------------------------------------------- ;;
;; Toutes les classes pr�d�finies ...                                     ;;
;; ---------------------------------------------------------------------- ;;
(define <singleton>            #f)
(define <character>            #f)
(define <symbol>               #f)
(define <function>             #f)
(define <generic-function>     #f)
(define <method>               #f)
(define <compiled-method>      #f)
(define <user-method>          #f)
(define <next-method>          #f)
(define <collection>           #f)
(define <mutable-collection>   #f)
(define <sequence>             #f)
(define <mutable-sequence>     #f)
(define <array>                #f)
(define <vector>               #f)
(define <simple-object-vector> #f)
(define <list>                 #f)
(define <pair>                 #f)
(define <empty-list>           #f)
(define <string>               #f)
(define <byte-string>          #f)
(define <number>               #f)
(define <complex>              #f)
(define <real>                 #f)
(define <float>                #f)
(define <single-float>         #f)
(define <double-float>         #f)
(define <extended-float>       #f)
(define <rational>             #f)
(define <integer>              #f)
(define <ratio>                #f)
(define <condition>            #f)
(define <serious-condition>    #f)
(define <warning>              #f)
(define <restart>              #f)
(define <error>                #f)
(define <sealed-object-error>  #f)
(define <simple-restart>       #f)
(define <abort>                #f)
(define <simple-error>         #f)
(define <type-error>           #f)
(define <simple-warning>       #f)

(define (init:all-classes)
  (set! <singleton>
	(class:make-class '<singleton>        '() (list <type>)     '()))

  (set! <character>
	(class:make-class '<character>        '() (list <object>)   '()))
  (set! <symbol>   
	(class:make-class '<symbol>           '() (list <object>)   '()))

  (set! <function> 
	(class:make-class '<function>         '() (list <type>)     '()))
  (set! <generic-function>
	(class:make-class '<generic-function> '() (list <function>) '()))
  (set! <method>   
	(class:make-class '<method>           '() (list <function>) '()))
  (set! <compiled-method>
	(class:make-class '<compiled-method>    '() (list <method>)   '()))
  (set! <user-method>
	(class:make-class '<user-method>      '() (list <method>)   '()))
  (set! <next-method>
	(class:make-class '<next-method>      '() (list <method>)   '()))

  (set! <collection>
	(class:make-class '<collection>       '() (list <object>)   '()))
  (set! <mutable-collection>
	(class:make-class '<mutable-collection> '() (list <collection>)   '()))
  (set! <sequence>
	(class:make-class '<sequence>         '() (list <collection>) '()))
  (set! <mutable-sequence>
	(class:make-class 
	 '<mutable-sequence> '() (list <mutable-collection> <sequence>) '()))
  (set! <array>
	(class:make-class '<array>           '() (list <mutable-sequence>) '()))
  (set! <vector>
	(class:make-class '<vector>           '() (list <array>) '()))
  (set! <simple-object-vector>
	(class:make-class '<simple-object-vector> '() (list <vector>) '()))
  (set! <list>
	(class:make-class '<list>             '() (list <mutable-sequence>) '()))
  (set! <pair>
	(class:make-class '<pair>             '() (list <list>)     '()))
  (set! <empty-list>
	(class:make-class '<empty-list>       '() (list <list>)     '()))
  (set! <string>
	(class:make-class '<string>           '() (list <mutable-sequence>)  '()))
  (set! <byte-string>
	(class:make-class '<byte-string>      '() (list <string> <vector>) '()))

  (set! <number>  
	(class:make-class '<number>           '() (list <object>)    '()))
  (set! <complex>
	(class:make-class '<complex>          '() (list <number>)    '()))
  (set! <real>
	(class:make-class '<real>             '() (list <complex>)   '()))
  (set! <float>
	(class:make-class '<float>            '() (list <real>)      '()))
  (set! <single-float>  
	(class:make-class '<single-float>     '() (list <float>)     '()))
  (set! <double-float>  
	(class:make-class '<double-float>     '() (list <float>)     '()))
  (set! <extended-float>  
	(class:make-class '<extended-float>   '() (list <float>)     '()))
  (set! <rational>
	(class:make-class '<rational>         '() (list <real>)      '()))
  (set! <integer>  
	(class:make-class '<integer>          '() (list <rational>)  '()))
  (set! <ratio>
	(class:make-class '<ratio>            '() (list <rational>)  '()))

  (set! <condition>
	(class:make-class '<condition>         '() (list <object>)     '()))
  (set! <serious-condition>
	(class:make-class '<serious-condition> '() (list <condition>)  '()))
  (set! <warning>
	(class:make-class '<warning>           '() (list <condition>)  '()))
  (set! <restart> 
	(class:make-class '<restart>           '() (list <condition>)  '()))
  (set! <error>
	(class:make-class '<error>             '() (list <serious-condition>) '()))
  (set! <sealed-object-error>
	(class:make-class '<sealed-object-error> '() (list <error>) '()))
  (set! <simple-restart>
	(class:make-class
	 '<simple-restart>
	 '()
	 (list <restart>)
	 (list (list 'KEYWORD 'CONDITION #f '()))))
  (set! <abort> 
	(class:make-class '<abort> '() (list <restart>) '()))
  (set! <simple-error> 
	(class:make-class 
	 '<simple-error>      
	 '() 
	 (list <error>)
	 (list (list 'SLOT 'CONDITION-FORMAT-STRING    '() 'CONSTANT <object> 
		     (list (cons 'INIT-KEYWORD (make-keyword 'FORMAT-STRING))))
	       (list 'SLOT 'CONDITION-FORMAT-ARGUMENTS '() 'CONSTANT <object>
		     (list (cons 'INIT-KEYWORD (make-keyword 'FORMAT-ARGUMENTS))))
	       (list 'KEYWORD 'FORMAT-STRING #f '())
	       (list 'KEYWORD 'FORMAT-ARGUMENTS #f '()))))
  (set! <type-error> 
	(class:make-class
	 '<type-error>
	 '()
	 (list <error>)
	 (list (list 'SLOT 'TYPE-ERROR-VALUE '() 'CONSTANT <object> 
		     (list (cons 'INIT-KEYWORD (make-keyword 'VALUE))))
	       (list 'SLOT 'TYPE-ERROR-TYPE '() 'CONSTANT <object>
		     (list (cons 'INIT-KEYWORD (make-keyword 'TYPE))))
	       (list 'KEYWORD 'VALUE #f '())
	       (list 'KEYWORD 'TYPE #f '()))))
  (set! <simple-warning> 
	(class:make-class 
	 '<simple-warning>
	 '()
	 (list <warning>)
	 (list (list 'SLOT 'CONDITION-FORMAT-STRING    '() 'CONSTANT <object> 
		     (list (cons 'INIT-KEYWORD (make-keyword 'FORMAT-STRING))))
	       (list 'SLOT 'CONDITION-FORMAT-ARGUMENTS '() 'CONSTANT <object>
		     (list (cons 'INIT-KEYWORD (make-keyword 'FORMAT-ARGUMENTS))))
	       (list 'KEYWORD 'FORMAT-STRING #f '())
	       (list 'KEYWORD 'FORMAT-ARGUMENTS #f '()))))
  )
	 

;; ---------------------------------------------------------------------- ;;
;; Initialisation de l'environnement global                               ;;
;; ---------------------------------------------------------------------- ;;
(define (global:init)

  (init:mop)
  (init:all-classes)
  
  (instance-class-set! $the-empty-list  <empty-list>)
  (instance-class-set! $the-true-value  <object>)
  (instance-class-set! $the-false-value <object>)
  
  ; Le premier �l�ment de l'environnement global est install� de fa�on 
  ; sp�ciale ... 
  (env:set-global!     
   (env:make-binding '<object>            <class>           <object>           #t))
  (env:add-global-env! 
   (env:make-binding '<type>              <class>           <type>             #t))
  (env:add-global-env! 
   (env:make-binding '<class>             <class>           <class>            #t))
  (env:add-global-env! 
   (env:make-binding '<singleton>         <class>           <singleton>        #t))
  (env:add-global-env! 
   (env:make-binding '<character>         <class>           <character>        #t))
  (env:add-global-env! 
   (env:make-binding '<symbol>            <class>           <symbol>           #t))

  (env:add-global-env! 
   (env:make-binding 'values              <compiled-method> (fun:values)       #t))
  (env:add-global-env! 
   (env:make-binding 'singleton           <compiled-method> (fun:singleton)    #t))
  (env:add-global-env! 
   (env:make-binding 'printf              <compiled-method> (fun:printf)       #t))
  (env:add-global-env!
   (env:make-binding 'simple-apply        <compiled-method> (fun:simple-apply) #t))
  (env:add-global-env!
   (env:make-binding 'quit                <compiled-method> (fun:quit)         #t))

  (set! fun:==
	(fun:make-predef
	 '== (list (list 'x <object>) (list 'y <object>)) #f '() #f
	 (make-return-value (list (list 'result <object>)) #f #f)
	 (lambda (args)
	   (let ((o1 (car args))
		 (o2 (cadr args))) 
	     (if (predef:== o1 o2) $the-true-value $the-false-value)))))

  (env:add-global-env!
   (env:make-binding '==                  <compiled-method> fun:==             #t))
  (env:add-global-env! 
   (env:make-binding 'slot-initialized?   <compiled-method> (fun:slot-init?)   #t))
  (env:add-global-env!
   (env:make-binding 'instance?           <compiled-method> (fun:instance?)    #t))
  (env:add-global-env!
   (env:make-binding 'subtype?            <compiled-method> (fun:subtype?)     #t))
  (env:add-global-env!
   (env:make-binding 'object-class        <compiled-method> (fun:object-class) #t))
  (env:add-global-env!
   (env:make-binding 'all-superclasses    <compiled-method> (fun:all-supers)   #t))
  (env:add-global-env!
   (env:make-binding 'direct-superclasses <compiled-method> (fun:direct-supers)#t))
  (env:add-global-env!
   (env:make-binding 'direct-subclasses   <compiled-method> (fun:direct-subs)  #t))

  (set! initialize-gf  (fun:ensure-generic-function 'initialize))
  (fun:add-method!     (fun:ensure-generic-function 'make) (fun:make))
  (fun:add-method!     initialize-gf (fun:initialize))
  
  (fun:add-method!     (fun:ensure-generic-function 'as-lowercase)   (fun:char-lower))
  (fun:add-method!     (fun:ensure-generic-function 'as-uppercase)   (fun:char-upper))
  (env:add-global-env! (env:make-binding 'int$char <compiled-method> (fun:int2char) #t))
  (env:add-global-env! (env:make-binding 'char$int <compiled-method> (fun:char2int) #t))
  (env:add-global-env! 
   (env:make-binding 'string$symbol <compiled-method> (fun:string2symbol) #t))
  (env:add-global-env! 
   (env:make-binding 'symbol$string <compiled-method> (fun:symbol2string) #t))
  
  (init:num)
  (init:fun)
  (init:error)
  (init:colls)
  (init:load)

;; --- Diverses initialisations (custom) -------------------------------- ;;
  (error:init)
;  (x:init)

;; --- On charge le fichier d'initialisation ---------------------------- ;;
  (fun:apply
   predef:load
   (list (make-instance <byte-string> (startup-file)))
   #f)

;; --- Fin de l'initialisation globale ... ------------------------------ ;;
  )

(define (fun:values)
  (fun:make-predef 'values '() #t '() #f (make-return-value '() #t <object>)
   (lambda (args) args)))

(define (fun:singleton)
  (fun:make-predef
   'singleton (list (list 'x <object>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args) 
     (let ((obj (car args)))
       (make-instance <singleton> obj)))))

(define (fun:printf)
  (fun:make-predef
   'printf (list (list 'x <byte-string>)) #t '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((obj (car args))
	   (l   (cdr args))) 
       (apply display-format-string 
	      (cons (instance-slots obj) l))
       $the-false-value))))

(define (fun:quit)
  (fun:make-predef 'quit '() #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args) (call-quit-cont))))

(define (fun:slot-init?)
  (fun:make-predef
   'slot-initialized?
   (list (list 'obj <object>) (list 'slot <generic-function>))
   #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let* ((obj       (car args))
	    (gf        (cadr args))
	    (name      (generic-name (instance-slots gf)))
	    (obj-slots (instance-slots obj)))
;; --- A corriger ... --------------------------------------------------- ;;
       (if (list? obj-slots)
;; --- ... -------------------------------------------------------------- ;;
	   (let ((x (vassoc name obj-slots)))
	     (if x
		 (if (eq? (binding-value x) $non-initialized) 
		     $the-false-value
		     $the-true-value)
		 (dylan:error 
		  "[* ERROR: getter `%=' does not access a slot of `%=' *]"
		  gf obj)))
	   (dylan:error 
	    "[* ERROR: getter `%=' does not access a slot of `%=' *]"
	    gf obj))))))

(define (fun:instance?)
  (fun:make-predef
   'instance? (list (list 'x <object>) (list 'y <type>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((obj (car args))
	   (typ (cadr args)))
       (if (class:general-instance? obj typ)
	   $the-true-value
	   $the-false-value)))))

(define (fun:subtype?)
  (fun:make-predef
   'subtype? (list (list 'x <type>) (list 'y <type>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((t1 (car args))
	   (t2 (cadr args)))
     (if (class:subtype? t1 t2)
	 $the-true-value
	 $the-false-value)))))

(define (fun:object-class)
  (fun:make-predef
   'object-class (list (list 'obj <object>)) #f '() #f
   (make-return-value (list (list 'result <class>)) #f #f)
   (lambda (args)
     (let ((o (car args)))
       (instance-class o)))))

(define (fun:all-supers)
  (fun:make-predef
   'all-superclasses (list (list 'c <class>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let ((c (car args)))
       (predef:make-list (class-prec-list (instance-slots c)))))))

(define (fun:direct-supers)
  (fun:make-predef
   'direct-superclasses (list (list 'c <class>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let ((c (car args)))
       (predef:make-list (class-supers (instance-slots c)))))))

(define (fun:direct-subs)
  (fun:make-predef
   'direct-subclasses (list (list 'c <class>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let ((c (car args)))
       (predef:make-list (class-direct-subs (instance-slots c)))))))

(define (fun:make)
  (fun:make-predef
   'make (list (list 'class <class>)) #t '() #t
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (apply class:make args))))

(define (fun:initialize)
  (fun:make-predef
   'initialize (list (list 'class <object>)) #t '() #t
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((obj (car args))
	   (rest (cdr args)))
       $the-false-value))))

(define (fun:simple-apply)
  (fun:make-predef
   'simple-apply (list (list 'fun <function>) (list 'seq <list>)) #f '() #f
   (make-return-value '() #f #f)
   (lambda (args)
     (let ((fun (car args))
	   (lst (cadr args)))
       (fun:apply fun (predef:scm-list lst) '())))))

(define (fun:char-upper)
  (fun:make-predef
   'as-uppercase
   (list (list 'c <character>)) #f '() #f
   (make-return-value (list (list 'result <character>)) #f #f)
   (lambda (args)
     (let* ((ch (car args))
	    (the-ch (instance-slots ch))
	    (new-ch (char-upcase the-ch)))
       (if (char=? the-ch new-ch)
	   ch
	   (make-instance <character> new-ch))))))

(define (fun:char-lower)
  (fun:make-predef
   'as-lowercase
   (list (list 'c <character>)) #f '() #f
   (make-return-value (list (list 'result <character>)) #f #f)
   (lambda (args)
     (let* ((ch (car args))
	    (the-ch (instance-slots ch))
	    (new-ch (char-downcase the-ch)))
       (if (char=? the-ch new-ch)
	   ch
	   (make-instance <character> new-ch))))))

(define (fun:int2char)
  (fun:make-predef
   'int$char
   (list (list 'int <integer>)) #f '() #f
   (make-return-value (list (list 'result <character>)) #f #f)
   (lambda (args)
     (let ((int (instance-slots (car args))))
       (make-instance <character> (integer->char int))))))

(define (fun:char2int)
  (fun:make-predef
   'int$char
   (list (list 'int <character>)) #f '() #f
   (make-return-value (list (list 'result <integer>)) #f #f)
   (lambda (args)
     (let ((ch (instance-slots (car args))))
       (make-instance <integer> (char->integer ch))))))

(define (fun:string2symbol)
  (fun:make-predef
   'string$symbol
   (list (list 'str <byte-string>)) #f '() #f
   (make-return-value (list (list 'result <symbol>)) #f #f)
   (lambda (args)
     (let ((str (instance-slots (car args))))
       (make-instance <symbol> (dylan:string->symbol str))))))

(define (fun:symbol2string)
  (fun:make-predef
   'symbol$string
   (list (list 'str <symbol>)) #f '() #f
   (make-return-value (list (list 'result <byte-string>)) #f #f)
   (lambda (args)
     (let ((sym (instance-slots (car args))))
       (make-instance <byte-string> (symbol->string sym))))))


(define (predef:make-symbol s) 
  (make-instance <symbol> s))

(define (predef:make-char str)
  (make-instance <character> (string->char str)))

(define (string->char str)
  (let ((c (string-ref str 1)))
    (if (char=? c #\\)
	(let ((c2 (string-ref str 2)))
	  (case c2
	    ((#\a) (integer->char 7))
	    ((#\b) (integer->char 8))
	    ((#\e) (integer->char 27))
	    ((#\f) (integer->char 10))
	    ((#\n) #\newline)
	    ((#\r) (integer->char 13))
	    ((#\t) (integer->char 9))
	    ((#\0) (integer->char 0))
	    (else c2)))
	c)))

(define (predef:== obj1 obj2)
  (or (eq? obj1 obj2)
      (let ((cl1 (instance-class obj1))
	    (cl2 (instance-class obj2))
	    (v1  (instance-slots obj1))
	    (v2  (instance-slots obj2)))
	(or (and (eq? cl1 <integer>) (eq? cl2 <integer>)
		 (fix:= v1 v2))
	    (and (eq? cl1 <double-float>) (eq? cl2 <double-float>)
		 (flo:= v1 v2))
	    (and (eq? cl1 <character>) (eq? cl2 <character>)
		 (char=? v1 v2))))))

(define initialize-gf #f)
(define fun:==        #f)

;; ---------------------------------------------------------------------- ;;
;; Les fonctions ...                                                      ;;
;; ---------------------------------------------------------------------- ;;
(define (init:fun)
  (env:add-global-env! 
   (env:make-binding '<function>         <class> <function>         #t))
  (env:add-global-env! 
   (env:make-binding '<generic-function> <class> <generic-function> #t))
  (env:add-global-env! 
   (env:make-binding '<compiled-method>  <class> <compiled-method>  #t))
  (env:add-global-env! 
   (env:make-binding '<user-method>      <class> <user-method>      #t))
  (env:add-global-env! 
   (env:make-binding '<next-method>      <class> <next-method>      #t))

  (env:add-global-env! 
   (env:make-binding 
    'generic-function-methods               <compiled-method> (fun:generic-methods) #t))
  (env:add-global-env! 
   (env:make-binding 'add-method            <compiled-method> (fun:add-method)      #t))
  (env:add-global-env! 
   (env:make-binding 
    'generic-function-mandatory-keywords    <compiled-method> (fun:mandatory-keys)  #t))
  (env:add-global-env! 
   (env:make-binding 'function-specializers <compiled-method> (fun:specializers)    #t))
  (env:add-global-env! 
   (env:make-binding 'function-arguments    <compiled-method> (fun:arguments)       #t))
  (env:add-global-env! 
   (env:make-binding 'applicable-method?    <compiled-method> (fun:applicable?)     #t))
  (env:add-global-env! 
   (env:make-binding 
    'sorted-applicable-methods              <compiled-method> (fun:sorted-methods)  #t))
  (env:add-global-env! 
   (env:make-binding 'find-method           <compiled-method> (fun:find-method)     #t))
  (env:add-global-env! 
   (env:make-binding 'remove-method         <compiled-method> (fun:remove-method)   #t))
  )

(define (fun:generic-methods)
  (fun:make-predef
   'generic-function-methods (list (list 'gf <generic-function>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let ((gf (car args)))
       (predef:make-list (generic-methods (instance-slots gf)))))))

(define (fun:add-method)
  (fun:make-predef
   'add-method (list (list 'gf <generic-function>) (list 'm <method>)) #f '() #f
   (make-return-value (list (list 'r1 <method>) (list 'r2 <object>)) #f #f)
   (lambda (args)
     (let ((gf (car args))
	   (mt (cadr args)))
       (fun:add-method! gf mt)))))

(define (fun:mandatory-keys)
  (fun:make-predef
   'generic-function-mandatory-keys
   (list (list 'l <generic-function>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let* ((gf (car args))
	    (ks (generic-keys (instance-slots gf))))
       (if ks
	   (predef:make-list
	    (map predef:make-symbol ks))
	   $the-false-value)))))

(define (fun:specializers)
  (fun:make-predef
   'function-specializers 
   (list (list 'l <function>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let* ((fun  (car args))
	    (typ  (instance-class fun)))
       (predef:make-list
	(if (eq? typ <generic-function>)
	    (generic-spec (instance-slots fun))
	    (map cadr (method-spec (instance-slots fun)))))))))

(define $all-symbol #f)

(define (fun:arguments)
  (set! $all-symbol (predef:make-symbol 'all))

  (fun:make-predef
   'function-arguments 
   (list (list 'l <function>)) #f '() #f
   (make-return-value 
    (list (list 'r1 <number>) (list 'r2 <object>) (list 'r3 <sequence>)) #f #f)
   (lambda (args)
     (let* ((fun  (car args))
	    (typ  (instance-class fun))
	    (gf?  (eq? typ <generic-function>))
	    (desc (instance-slots fun))
	    (nreq (if gf? (generic-nreq desc) (method-nreq desc)))
	    (rest (if gf? (generic-rest? desc) (method-rest? desc)))
	    (keys (if gf? (generic-keys desc) (method-keys desc)))
	    (all? (if gf? (generic-all-keys? desc) (method-all-keys? desc))))
       (list
	(predef:make-int nreq)
	(if rest $the-true-value $the-false-value)
	(if all?
	    $all-symbol
	    (if keys
		(predef:make-list (map predef:make-symbol keys))
		$the-false-value)))))))

(define (fun:applicable?)
  (fun:make-predef
   'applicable-method? 
   (list (list 'l <function>)) #t '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let* ((fun   (car args))
	    (typ   (instance-class fun))
	    (sargs (cdr args)))
       (if (eq? typ <generic-function>)
	   (let loop ((methods (generic-methods (instance-slots fun))))
	     (if (null? methods)
		 $the-false-value
		 (if (fun:applicable-method? (car methods) sargs)
		     $the-true-value
		     (loop (cdr methods)))))
	   (if (fun:applicable-method? fun sargs)
	       $the-true-value
	       $the-false-value))))))

(define (fun:sorted-methods)
  (fun:make-predef
   'sorted-applicable-methods
   (list (list 'l <generic-function>)) #t '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let* ((fun   (car args))
	    (desc  (instance-slots fun))
	    (sargs (cdr args))
	    (nreq  (generic-nreq desc))
	    (nsupp (length sargs)))
       (if (= nsupp nreq)
	   (let ((s1/s2 (fun:sort-methods (generic-methods desc) sargs)))
	     (list (predef:make-list (car s1/s2))
		   (predef:make-list (cadr s1/s2))))
	   (dylan:error 
	    "wrong number of arguments in call to `sorted-applicable-methods'"))))))


(define (fun:find-method)
  (fun:make-predef
   'find-method
   (list (list 'l <generic-function>) (list 'spec <list>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let* ((fun    (car args))
	    (splst  (predef:scm-list (cadr args))))
       (let loop ((l (generic-methods (instance-slots fun))))
	 (if (null? l)
	     $the-false-value
	     (let ((met (car l)))
	       (let loop2 ((mspl (method-spec (instance-slots met)))
			   (spl  splst))
		 (cond
		  ((null? mspl)
		   (if (null? spl)
		       met
		       (loop (cdr l))))
		  ((null? spl)
		   (loop (cdr l)))
		  (else
		   (let ((msp (cadar mspl)) (sp (car spl)))
		     (cond
		      ((eq? msp sp) (loop2 (cdr mspl) (cdr spl)))
		      ((eq? (instance-class msp) <singleton>)
		       (if (eq? (instance-slots msp) sp)
			   (loop2 (cdr mspl) (cdr spl))
			   (loop (cdr l))))
		      (else
		       (loop (cdr l)))))))))))))))

(define (fun:remove-method)
  (fun:make-predef
   'remove-method
   (list (list 'gf <generic-function>) (list 'met <method>)) #f '() #f
   (make-return-value (list (list 'result <method>)) #f #f)
   (lambda (args)
     (let* ((gf   (car args))
	    (fun  (cadr args))
	    (newl (let loop ((l (generic-methods (instance-slots gf))))
		    (if (null? l)
			(dylan:error "method is not in generic function: `%='" gf)
			(let ((m (car l)))
			  (if (eq? m fun)
			      (cdr l)
			      (cons m (loop (cdr l)))))))))
       (generic-methods-set! (instance-slots gf) newl)
       fun))))
	       
;; ---------------------------------------------------------------------- ;;
;; Les collections ...                                                    ;;
;; ---------------------------------------------------------------------- ;;
(define (init:colls)
  (env:add-global-env! 
   (env:make-binding '<collection>           <class> <collection>           #t))
  (env:add-global-env! 
   (env:make-binding '<mutable-collection>   <class> <mutable-collection>   #t))
  (env:add-global-env!
   (env:make-binding '<sequence>             <class> <sequence>             #t))
  (env:add-global-env!
   (env:make-binding '<mutable-sequence>     <class> <mutable-sequence>     #t))
  (env:add-global-env!
   (env:make-binding '<array>                <class> <array>                #t))
  (env:add-global-env!
   (env:make-binding '<vector>               <class> <vector>               #t))
  (env:add-global-env!
   (env:make-binding '<simple-object-vector> <class> <simple-object-vector> #t))
  (env:add-global-env! 
   (env:make-binding '<list>                 <class> <list>                 #t))
  (env:add-global-env! 
   (env:make-binding '<pair>                 <class> <pair>                 #t))
  (env:add-global-env! 
   (env:make-binding '<empty-list>           <class> <empty-list>           #t))
  (env:add-global-env! 
   (env:make-binding '<string>               <class> <string>               #t))
  (env:add-global-env! 
   (env:make-binding '<byte-string>          <class> <byte-string>          #t))
  (env:add-global-env!
   (env:make-binding 'pair              <compiled-method> (fun:pair)              #t))
  (env:add-global-env!
   (env:make-binding 'list              <compiled-method> (fun:list)              #t))
  (env:add-global-env!
   (env:make-binding 'head              <compiled-method> (fun:head)              #t))
  (env:add-global-env!
   (env:make-binding 'tail              <compiled-method> (fun:tail)              #t))
  (env:add-global-env!
   (env:make-binding 'head-setter       <compiled-method> (fun:head-setter)       #t))
  (env:add-global-env!
   (env:make-binding 'tail-setter       <compiled-method> (fun:tail-setter)       #t))
  (env:add-global-env!
   (env:make-binding 'make$array        <compiled-method> (fun:make-array)        #t))
  (env:add-global-env!
   (env:make-binding 'array$dims        <compiled-method> (fun:array-dims)        #t))
  (env:add-global-env!
   (env:make-binding 'array$elt         <compiled-method> (fun:array-elt)         #t))
  (env:add-global-env!
   (env:make-binding 'array$elt-setter  <compiled-method> (fun:array-elt-setter)  #t))
  (env:add-global-env!
   (env:make-binding 'make$vector       <compiled-method> (fun:make-vector)       #t))
  (env:add-global-env!
   (env:make-binding 'make$string       <compiled-method> (fun:make-string)       #t))
  (env:add-global-env!
   (env:make-binding 'string$size       <compiled-method> (fun:string-size)       #t))
  (env:add-global-env!
   (env:make-binding 'string$elt        <compiled-method> (fun:string-elt)        #t))
  (env:add-global-env!
   (env:make-binding 'string$elt-setter <compiled-method> (fun:string-elt-setter) #t))

  (fun:add-method! (fun:ensure-generic-function 'as-lowercase) (fun:as-lower))
  (fun:add-method! (fun:ensure-generic-function 'as-lowercase!) (fun:as-lower!))
  (fun:add-method! (fun:ensure-generic-function 'as-uppercase) (fun:as-upper))
  (fun:add-method! (fun:ensure-generic-function 'as-uppercase!) (fun:as-upper!))
  
  (set! fwd-protoco-gf
	(fun:ensure-generic-function 'forward-iteration-protocol))
  
  (fun:add-method! (fun:ensure-generic-function '<) (fun:string<))
  )

(define (fun:pair)
  (fun:make-predef
   'pair (list (list 'x <object>) (list 'y <object>)) #f '() #f
   (make-return-value (list (list 'result <list>)) #f #f)
   (lambda (args)
     (let ((o1 (car args))
	   (o2 (cadr args)))
       (predef:pair o1 o2)))))

(define (fun:list)
  (fun:make-predef
   'list '() #t '() #f
   (make-return-value (list (list 'result <list>)) #f #f)
   (lambda (args)
     (predef:make-list args))))

(define (fun:head)
  (fun:make-predef
   'head (list (list 'l <list>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((l (car args)))
       (if (eq? l $the-empty-list)
	   l
	   (car (instance-slots l)))))))

(define (fun:tail)
  (fun:make-predef
   'tail (list (list 'l <list>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((l (car args)))
       (if (eq? l $the-empty-list)
	   l
	   (cdr (instance-slots l)))))))

(define (fun:head-setter)
  (fun:make-predef
   'head-setter (list (list 'o <object>) (list 'l <pair>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((v (car args))
	   (p (cadr args)))
       (set-car! (instance-slots p) v)
       v))))

(define (fun:tail-setter)
  (fun:make-predef
   'tail-setter (list (list 'o <object>) (list 'l <pair>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((v (car args))
	   (p (cadr args)))
       (set-cdr! (instance-slots p) v)
       v))))

(define (fun:make-array)
  (fun:make-predef
   'make$array
   (list (list 'dims <list>) (list 'fill <object>)) #f '() #f
   (make-return-value (list (list 'result <array>)) #f #f)
   (lambda (args)
     (let* ((nums (car args))
	    (dims (predef:scm-list nums))
	    (fill (cadr args))
	    (size (let loop ((i 1) (d dims))
		    (if (null? d) i (loop (* i (instance-slots (car d))) (cdr d))))))
       (make-instance
	<array>
	(vector nums (make-vector size fill)))))))

(define (fun:array-dims)
  (fun:make-predef
   'array$dimensions
   (list (list 'array <array>)) #f '() #f
   (make-return-value (list (list 'result <sequence>)) #f #f)
   (lambda (args)
     (let ((ar (car args)))
       (vector-ref (instance-slots ar) 0)))))

(define (fun:array-elt)
  (fun:make-predef
   'array$elt
   (list (list 'array <array>) (list 'index <integer>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((ar  (car args))
	   (idx (instance-slots (cadr args))))
       (vector-ref (vector-ref (instance-slots ar) 1) idx)))))

(define (fun:array-elt-setter)
  (fun:make-predef
   'array$elt-setter
   (list (list 'v <object>) (list 'array <array>) (list 'index <integer>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((val (car args))
	   (ar  (cadr args))
	   (idx (instance-slots (caddr args))))
       (vector-set! (vector-ref (instance-slots ar) 1) idx val)
       val))))

(define (fun:make-vector)
  (fun:make-predef
   'make$vector
   (list (list 'size <integer>) (list 'fill <object>)) #f '() #f
   (make-return-value (list (list 'result <simple-object-vector>)) #f #f)
   (lambda (args)
     (let* ((num  (car args))
	    (size (instance-slots num))
	    (fill (cadr args)))
       (make-instance
	<simple-object-vector>
	(vector
	 (predef:make-list (list num))
	 (make-vector size fill)))))))

(define (fun:make-string)
  (fun:make-predef
   'make$string
   (list (list 'size <integer>) (list 'fill <character>)) #f '() #f
   (make-return-value (list (list 'result <simple-object-vector>)) #f #f)
   (lambda (args)
     (let* ((num  (car args))
	    (size (instance-slots num))
	    (fill (instance-slots (cadr args))))
       (make-instance
	<byte-string>
	(make-string size fill))))))

(define (fun:string-size)
  (fun:make-predef
   'string$size
   (list (list 'array <string>)) #f '() #f
   (make-return-value (list (list 'result <integer>)) #f #f)
   (lambda (args)
     (let ((ar (car args)))
       (predef:make-int (string-length (instance-slots ar)))))))

(define (fun:string-elt)
  (fun:make-predef
   'string$elt
   (list (list 'array <string>) (list 'index <integer>)) #f '() #f
   (make-return-value (list (list 'result <character>)) #f #f)
   (lambda (args)
     (let ((str (instance-slots (car args)))
	   (idx (instance-slots (cadr args))))
       (make-instance <character> (string-ref str idx))))))

(define (fun:string-elt-setter)
  (fun:make-predef
   'string$elt-setter
   (list (list 'v <character>) (list 'array <string>) (list 'index <integer>)) #f '() #f
   (make-return-value (list (list 'result <character>)) #f #f)
   (lambda (args)
     (let* ((ch  (car args))
	    (val (instance-slots ch))
	    (ar  (cadr args))
	    (idx (instance-slots (caddr args))))
       (string-set! (instance-slots ar) idx val)
       ch))))

(define (fun:string<)
  (fun:make-predef
   '<
   (list (list 's1 <string>) (list 's2 <string>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let ((v1 (instance-slots (car args)))
	   (v2 (instance-slots (cadr args))))
       (if (string<? v1 v2)
	   $the-true-value
	   $the-false-value)))))

(define (fun:as-lower)
  (fun:make-predef
   'as-lowercase
   (list (list 's <byte-string>)) #f '() #f
   (make-return-value (list (list 'result <byte-string>)) #f #f)
   (lambda (args)
     (let ((str (car args)))
       (make-instance <byte-string> 
		      (list->string 
		       (map char-downcase 
			    (string->list (instance-slots str)))))))))

(define (fun:as-lower!)
  (fun:make-predef
   'as-lowercase!
   (list (list 's <byte-string>)) #f '() #f
   (make-return-value (list (list 'result <byte-string>)) #f #f)
   (lambda (args)
     (let ((str (car args)))
       (instance-slots-set!
	str
	(list->string 
	 (map char-downcase 
	      (string->list (instance-slots str)))))))))

(define (fun:as-upper)
  (fun:make-predef
   'as-uppercase
   (list (list 's <byte-string>)) #f '() #f
   (make-return-value (list (list 'result <byte-string>)) #f #f)
   (lambda (args)
     (let ((str (car args)))
       (make-instance <byte-string> 
		      (list->string 
		       (map char-upcase 
			    (string->list (instance-slots str)))))))))

(define (fun:as-upper!)
  (fun:make-predef
   'as-uppercase!
   (list (list 's <byte-string>)) #f '() #f
   (make-return-value (list (list 'result <byte-string>)) #f #f)
   (lambda (args)
     (let ((str (car args)))
       (instance-slots-set!
	str
	(list->string 
	 (map char-upcase 
	      (string->list (instance-slots str)))))))))

(define (predef:scm-list pair)
  (if (eq? pair $the-empty-list)
      '()
      (let ((vals (instance-slots pair)))
	(cons (car vals)
	      (predef:scm-list (cdr vals))))))

(define (predef:make-list l) 
  (if (null? l)
      $the-empty-list
      (predef:pair (car l) (predef:make-list (cdr l)))))

(define (predef:pair x y)    
  (make-instance <pair> (cons x y)))

(define (predef:make-vector l)
  (let* ((v (list->vector l))
	 (len (vector-length v)))
  (make-instance 
   <simple-object-vector> 
   (vector
    (predef:make-list (list (predef:make-int len)))
    (list->vector l)))))

(define (predef:make-byte-string str)
  (make-instance <byte-string> (string->dylan-string str)))

(define (string->dylan-string str)
  (list->string
   (let loop ((chars (string->list str)))
     (if (null? chars)
	 '()
	 (let ((c (car chars)))
	   (if (char=? c #\\)
	       (let ((c2 (cadr chars)))
		 (cons
		  (case c2
		    ((#\a) (integer->char 7))
		    ((#\b) (integer->char 8))
		    ((#\e) (integer->char 27))
		    ((#\f) (integer->char 10))
		    ((#\n) #\newline)
		    ((#\r) (integer->char 13))
		    ((#\t) (integer->char 9))
		    ((#\0) (integer->char 0))
		    (else c2))
		  (loop (cddr chars))))
	       (cons c (loop (cdr chars)))))))))
		  
(define fwd-protoco-gf #f)

;; ---------------------------------------------------------------------- ;;
;; Les nombres ...                                                        ;;
;; ---------------------------------------------------------------------- ;;
(define (init:num)
  (env:add-global-env!
   (env:make-binding '<number>           <class> <number>           #t))
  (env:add-global-env!
   (env:make-binding '<complex>          <class> <complex>          #t))
  (env:add-global-env!
   (env:make-binding '<real>             <class> <real>             #t))
  (env:add-global-env!
   (env:make-binding '<float>            <class> <float>            #t))
  (env:add-global-env!
   (env:make-binding '<single-float>     <class> <single-float>     #t))
  (env:add-global-env!
   (env:make-binding '<double-float>     <class> <double-float>     #t))
  (env:add-global-env!
   (env:make-binding '<extended-float>   <class> <extended-float>   #t))
  (env:add-global-env! 
   (env:make-binding '<rational>         <class> <rational>         #t))
  (env:add-global-env! 
   (env:make-binding '<integer>          <class> <integer>          #t))
  (env:add-global-env! 
   (env:make-binding '<ratio>            <class> <ratio>            #t))

  
  (install-predef! (fun:ensure-generic-function '+)        fun:+)
  (install-predef! (fun:ensure-generic-function '-)        fun:-)
  (install-predef! (fun:ensure-generic-function '*)        fun:*)
  (install-predef! (fun:ensure-generic-function '/)        fun:/)
  (install-predef! (fun:ensure-generic-function '^)        fun:^)
  (install-predef! (fun:ensure-generic-function '<)        fun:num<)
  (install-predef! (fun:ensure-generic-function '=)        fun:num=)
  (install-predef! (fun:ensure-generic-function 'negative) fun:negate)
  (install-predef! (fun:ensure-generic-function 'floor)    fun:floor)
  (install-predef! (fun:ensure-generic-function 'modulo)   fun:modulo)
  )

(define (predef:make-int i)    (make-instance <integer> i))
(define (predef:make-float f)  (make-instance <double-float> f))

(define +-gf #f)
(define <-gf #f)
(define =-gf #f)

(define (fun:+ gf old-code)
  (set! +-gf gf)
  (fun:add-method! gf 
		   (fun:make-predef
		    '+ (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (predef:make-int (fix:+ x1-val x2-val)))
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:+ (fix->flo x1-val) x2-val)))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:+ x1-val x2-val)))
	      ((eq? x2-cl <integer>)
	       (predef:make-float (flo:+ x1-val (fix->flo x2-val))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:- gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    '- (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (predef:make-int (fix:- x1-val x2-val)))
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:- (fix->flo x1-val) x2-val)))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:- x1-val x2-val)))
	      ((eq? x2-cl <integer>)
	       (predef:make-float (flo:- x1-val (fix->flo x2-val))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:* gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    '* (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (predef:make-int (fix:* x1-val x2-val)))
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:* (fix->flo x1-val) x2-val)))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:* x1-val x2-val)))
	      ((eq? x2-cl <integer>)
	       (predef:make-float (flo:* x1-val (fix->flo x2-val))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:/ gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    '/ (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (predef:make-float (flo:/ (fix->flo x1-val) (fix->flo x2-val))))
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:/ (fix->flo x1-val) x2-val)))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (predef:make-float (flo:/ x1-val x2-val)))
	      ((eq? x2-cl <integer>)
	       (predef:make-float (flo:/ x1-val (fix->flo x2-val))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:^ gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    '^ (list (list 'x <number>) (list 'y <integer>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x2-cl <integer>)
	     (cond
	      ((or (eq? x1-cl <integer>) (eq? x1-cl <double-float>))
	       (let ((res (expt x1-val x2-val)))
		 (if (exact? res)
		     (predef:make-int res)
		     (predef:make-float res))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:num< gf old-code)
  (set! <-gf gf)
  (fun:add-method! gf 
		   (fun:make-predef
		    '< (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (if (fix:< x1-val x2-val) $the-true-value $the-false-value))
	      ((eq? x2-cl <double-float>)
	       (if (flo:< (fix->flo x1-val) x2-val) $the-true-value $the-false-value))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (if (flo:< x1-val x2-val) $the-true-value $the-false-value))
	      ((eq? x2-cl <integer>)
	       (if (flo:< x1-val (fix->flo x2-val)) $the-true-value $the-false-value))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:num= gf old-code)
  (set! =-gf gf)
  (fun:add-method! gf 
		   (fun:make-predef
		    '= (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (if (fix:= x1-val x2-val) $the-true-value $the-false-value))
	      ((eq? x2-cl <double-float>)
	       (if (flo:= (fix->flo x1-val) x2-val) $the-true-value $the-false-value))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (if (flo:= x1-val x2-val) $the-true-value $the-false-value))
	      ((eq? x2-cl <integer>)
	       (if (flo:= x1-val (fix->flo x2-val)) $the-true-value $the-false-value))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:floor gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    'floor (list (list 'x <real>)) #f '() #f 
		    (make-return-value 
		     (list (list 'r1 <integer>) (list 'r2 <real>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (null? (cdr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1)))
	   (cond
	    ((eq? x1-cl <double-float>)
	     (let* ((fl (floor x1-val))
		    (rt (flo:- x1-val fl)))
	       (list (predef:make-int (inexact->exact fl))
		     (predef:make-float rt))))
	    ((eq? x1-cl <integer>)
	     x1)
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:modulo gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    'modulo (list (list 'x <number>) (list 'y <number>)) #f '() #f 
		    (make-return-value (list (list 'result <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (pair? (cdr args)) (null? (cddr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1))
		(x2     (cadr args)) 
		(x2-cl  (instance-class x2))
		(x2-val (instance-slots x2)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (cond
	      ((eq? x2-cl <integer>)
	       (predef:make-int (modulo x1-val x2-val)))
	      ((eq? x2-cl <double-float>)
	       (let* ((dv (flo:/ (fix->flo x1-val) x2-val))
		      (fl (floor dv)))
		 (predef:make-float (flo:- dv fl))))
	      (else
	       (old-code args))))
	    ((eq? x1-cl <double-float>)
	     (cond
	      ((eq? x2-cl <double-float>)
	       (let* ((dv (flo:/ x1-val x2-val))
		      (fl (floor dv)))
		 (predef:make-float (flo:- dv fl))))
	      ((eq? x2-cl <integer>)
	       (let* ((dv (flo:/ x1-val (fix->flo x2-val)))
		      (fl (floor dv)))
		 (predef:make-float (flo:- dv fl))))
	      (else
	       (old-code args))))
	    (else
	     (old-code args))))
	 (old-code args)))))

(define (fun:negate gf old-code)
  (fun:add-method! gf 
		   (fun:make-predef
		    'negative (list (list 'x <number>)) #f '() #f 
		    (make-return-value (list (list 'r1 <number>)) #f #f)
		    #f))
  (generic-code-set! 
   (instance-slots gf)
   (lambda (args)
     (if (and (pair? args) (null? (cdr args)))
	 (let* ((x1     (car args))  
		(x1-cl  (instance-class x1))
		(x1-val (instance-slots x1)))
	   (cond
	    ((eq? x1-cl <integer>)
	     (predef:make-int (fix:- 0 x1-val)))
	    ((eq? x1-cl <double-float>)
	     (predef:make-float (flo:- 0.0 x1-val)))
	    (else
	     (old-code args))))
	 (old-code args)))))

;; ---------------------------------------------------------------------- ;;
;; Le protocole d'exceptions (conditions) ...                             ;;
;; ---------------------------------------------------------------------- ;;
(define (init:error)
  (class:adjust-slots! <simple-error> #f)
  (class:add-methods!  <simple-error>)
  (class:adjust-slots! <type-error> #f)
  (class:add-methods!  <type-error>)
  (class:adjust-slots! <simple-warning> #f)
  (class:add-methods!  <simple-warning>)
  
  (env:add-global-env!
   (env:make-binding '<condition>           <class> <condition>           #t))
  (env:add-global-env!
   (env:make-binding '<serious-condition>   <class> <serious-condition>   #t))
  (env:add-global-env!
   (env:make-binding '<warning>             <class> <warning>             #t))
  (env:add-global-env!
   (env:make-binding '<restart>             <class> <restart>             #t))
  (env:add-global-env!
   (env:make-binding '<error>               <class> <error>               #t))
  (env:add-global-env!
   (env:make-binding '<simple-error>        <class> <simple-error>        #t))
  (env:add-global-env!
   (env:make-binding '<type-error>          <class> <type-error>          #t))
  (env:add-global-env!
   (env:make-binding '<sealed-object-error> <class> <sealed-object-error> #t))
  (env:add-global-env!
   (env:make-binding '<simple-warning>      <class> <simple-warning>      #t))
  (env:add-global-env!
   (env:make-binding '<simple-restart>      <class> <simple-restart>      #t))
  (env:add-global-env!
   (env:make-binding '<abort>               <class> <abort>               #t))
  (env:add-global-env!
   (env:make-binding 'error            <compiled-method> (predef:error)      #t))
  (env:add-global-env!
   (env:make-binding 'signal           <compiled-method> (predef:signal)     #t))
  (env:add-global-env!
   (env:make-binding 'check-type       <compiled-method> (predef:check-type) #t))

  (let ((bind (make-binding 'error-message $unbound $unbound #f)))
    (set! error-message bind)
    (env:add-global-env! bind))
  
  (set! default-handler-gf (fun:ensure-generic-function 'default-handler))
  (fun:add-method! default-handler-gf (predef:warning))

  (set! $default-test
	(fun:make-predef 'test (list (list 'cond <condition>)) #f '() #f 
			 (make-return-value '() #f #f) 
			 (lambda (args) $the-true-value))))
  

(define $default-test      #f)
(define default-handler-gf #f)
(define error-message      #f)

(define (predef:check-type)
  (fun:make-predef
   'check-type (list (list 'value <object>) (list 'type <type>)) #f '() #f
   (make-return-value (list (list 'value <object>)) #f #f)
   (lambda (args)
     (let ((val (car args))
	   (type (cadr args)))
       (error:check-type val type)))))

(define (predef:signal)
  (fun:make-predef
   'signal (list (list 'obj <object>)) #t '() #f 
   (make-return-value '() #f #f)
   (lambda (args)
     (let ((obj (car args))
	   (l (cdr args)))
       (cond
	((class:general-instance? obj <condition>)
	 (if (null? l)
	     (error:signal obj)
	     (dylan:error "[* FATAL ERROR : Invalid call to `signal' *]")))
	((class:general-instance? obj <byte-string>)
	 (error:signal
	  (class:make 
	   <simple-warning>
	   (make-instance <symbol> 'FORMAT-STRING)
	   obj
	   (make-instance <symbol> 'FORMAT-ARGUMENTS)
	   (predef:make-list l)))
	 (error:abort))
	(else
	 (dylan:error "Invalid call to `signal'")))))))

(define (predef:error)
  (fun:make-predef
   'error (list (list 'obj <object>)) #t '() #f 
   (make-return-value '() #f #f)
   (lambda (args)
     (let ((obj (car args))
	   (l (cdr args)))
       (cond
	((class:general-instance? obj <condition>)
	 (if (null? l)
	     (begin
	       (error:signal obj)
	       (error:abort))
	     (dylan:error "[* FATAL ERROR : Invalid call to `error' *]")))
	((class:general-instance? obj <byte-string>)
	 (error:signal
	  (class:make 
	   <simple-error>
	   (make-instance <symbol> 'FORMAT-STRING)
	   obj
	   (make-instance <symbol> 'FORMAT-ARGUMENTS)
	   (predef:make-list l)))
	 (error:abort))
	(else
	 (dylan:error "[* FATAL ERROR : Invalid call to `error' *]")))))))

(define (predef:warning)
  (fun:make-predef
   'default-handler (list (list 'type <warning>)) #f '() #f
   (make-return-value (list (list 'result <object>)) #f #f)
   (lambda (args)
     (let* ((cnd (car args))
	    (format-str   (class:slot-get cnd 'condition-format-string))
	    (format-arg   (class:slot-get cnd 'condition-format-arguments))
	    (the-fmt-args (if (eq? format-arg $non-initialized)
			      '()
			      (predef:scm-list format-arg))))
       (if (eq? format-str $non-initialized)
	   (dylan:error "[* ERROR: in default handler for <warning> *]")
	   (begin
	     (error:check-type format-str <byte-string>)
	     (apply display-format-string 
		    (cons (instance-slots format-str) the-fmt-args))
	     $the-false-value))))))
       


;; ---------------------------------------------------------------------- ;;
;; Fonction pour charger un fichier. Les deux param�tres sont :           ;;
;;      - la cha�ne indiquant le chemin du fichier � charger et           ;;
;;      - un bool�en indiquant si il faut lire interactivement.           ;;
;; ---------------------------------------------------------------------- ;;
(define *lineno* 0)
(define (inc-lineno!) (set! *lineno* (+ 1 *lineno*)))

(define (dylan:load port interact?)
  (set! *end-of-constituent* #f)
  (set! *multi-line?* (not interact?))
  (set! *lineno* 1)
  (init-lexer port)
  (parser auxiliary-lexer syntax-error))

;; ---------------------------------------------------------------------- ;;
;; Lexer auxiliaire ...                                                   ;;
;; ---------------------------------------------------------------------- ;;
(define (auxiliary-lexer)
  (let ((x (if *end-of-constituent* '(0) (lexer))))
    x))

;; ---------------------------------------------------------------------- ;;
;; Fonction d'erreur syntaxique ...                                       ;;
;; ---------------------------------------------------------------------- ;;
(define (syntax-error token)
  (dylan:error "SYNTAX ERROR (line %d): unexpected `%s'" 
	       (make-instance <integer> *lineno*)
	       (make-instance <byte-string> token)))

;; ---------------------------------------------------------------------- ;;
;; Diverses initialisations ...                                           ;;
;; ---------------------------------------------------------------------- ;;
(define (init:load)
  (set! predef:load 
	(fun:make-predef
	 'load (list (list 'filename <byte-string>)) #f '() #f
	 (make-return-value '() #f #f)
	 (lambda (args)
	   (let* ((file (car args))
		  (p (secure-open-input-file (instance-slots file))))
	     (if p
		 (let ((ast (dylan:load p #f)))
		   (close-input-port p)
		   (for-each (lambda (form)
			       ((gen:gen-constituent form) #f))
			     ast)
		   $the-false-value)
		 (dylan:error "unable to load file: `%s'" file))))))

  (env:add-global-env!
   (env:make-binding 'load              <compiled-method> predef:load   #t))
  (env:add-global-env!
   (env:make-binding 'reset-environment <compiled-method> (predef:init) #t))

  )

;; --- Fonction pour le chargement d'un fichier... ---------------------- ;;
(define predef:load #f)

;; --- Fonction de r�initialisation de l'env. global -------------------- ;;
(define (predef:init)
  (fun:make-predef
   'reset-environment
   '() #f '() #f (make-return-value '() #f #f)
   (lambda (args)
     (global:init)
     $the-false-value)))

;; --- Fin du fichier global.scm ---------------------------------------- ;;
