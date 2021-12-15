class Hash
  def method_missing(sym,*args)
    if(sym[-1]=="=")
       self.store(sym[0...-1].to_sym, args[0])
    else
       self.fetch(sym.to_sym)
    end
  end
end
